import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smart_routines/app/data/models/routine/routine.dart';
import 'package:smart_routines/app/data/models/smart_model/smart_model.dart';
import 'package:smart_routines/app/domain/repositories/smart_model_repository.dart';
import 'package:smart_routines/core/extensions/property_extension.dart';

/// [RoutineService] is a service class that manages smart models and routines.
///
/// This class is responsible for loading smart models and routines from the
/// database, listening for changes, and setting up routine automation based
/// on the loaded data. It provides streams to observe changes in smart models
/// and routines, and methods to add, update, delete, and clear smart models
/// and routines.
///
/// It manages the data using `BehaviorSubject` and interacts with a repository
/// to perform database operations.
/// The class uses `BehaviorSubject` to manage the state of smart models and
/// routines, and it interacts with a repository to perform database operations.
///

@lazySingleton
class RoutineService {
  RoutineService(this._smartModelRepository);
  final SmartModelRepository _smartModelRepository;

  final _smartModelsSubject = BehaviorSubject<Map<String, SmartModel>>();

  final _routinesSubject = BehaviorSubject<Map<String, Routine>>();

  Stream<Map<String, SmartModel>> get smartModelsStream =>
      _smartModelsSubject.stream;

  Stream<Map<String, Routine>> get routinesStream => _routinesSubject.stream;

  /// Initializes the data by loading smart models and routines from
  /// the database and listening for changes.
  ///
  /// This method is annotated with `@PostConstruct(preResolve: true)`, which
  /// tells the dependency injection container to call this method after
  /// creating an instance of the service and before resolving any dependencies.
  @PostConstruct(preResolve: true)
  Future<void> initializeData() async {
    await _loadModelsFromDb();
    _listenDeviceChanges();
  }

  /// Loads smart models and routines from the database and updates the
  /// smart models and routines streams.
  Future<void> _loadModelsFromDb() async {
    final smartModels = await _smartModelRepository.getSmartModels();
    final routines = await _smartModelRepository.getRoutines();

    final smartModelMap = smartModels.fold<Map<String, SmartModel>>(
      {},
      (map, smartModel) {
        map[smartModel.id] = smartModel;
        return map;
      },
    );

    final routineMap = routines.fold<Map<String, Routine>>(
      {},
      (map, routine) {
        map[routine.id] = routine;
        return map;
      },
    );

    _smartModelsSubject.add(smartModelMap);
    _routinesSubject.add(routineMap);
  }

  /// Listens for changes in smart models and sets up routine automation
  /// based on the loaded data.
  void _listenDeviceChanges() {
    _smartModelsSubject.listen((smartModels) => _setupRoutineAutomation());
  }

  /// Sets up routine automation by checking the trigger conditions of each
  /// routine and executing the actions if the trigger conditions are met.
  /// This method is called whenever there is a change in the smart models.
  ///
  /// It iterates over all the routines and checks if the trigger conditions
  /// are met. If the trigger conditions are met,
  /// it executes the routine actions.
  Future<void> _setupRoutineAutomation() async {
    final smartModels = _smartModelsSubject.value;
    final routines = _routinesSubject.value;

    for (final routine in routines.values) {
      if (routine.isActive == false) continue;
      final triggerModel = smartModels[routine.trigger.modelId];
      if (triggerModel == null || triggerModel.isActive == false) continue;

      final triggerProperty =
          triggerModel.getProperty(routine.trigger.propertyName);

      if (triggerProperty == null) continue;

      if (triggerProperty.checkTrigger(routine.trigger)) {
        await _executeRoutineActions(routine.actions);
      }
    }
  }

  /// Executes the actions of a routine by updating the property values
  /// of the smart models.
  Future<void> _executeRoutineActions(
    List<Action> actions,
  ) async {
    final smartModels = _smartModelsSubject.value;

    for (final action in actions) {
      final actionModel = smartModels[action.modelId];
      if (actionModel == null || actionModel.isActive == false) continue;

      final property = actionModel.getProperty(action.propertyName);
      if (property == null) continue;
      if (property.value == action.value) continue;

      await updatePropertyValue(
        modelId: actionModel.id,
        propertyName: property.name,
        value: action.value,
      );
    }
  }

  /// Updates the value of a property in a smart model and updates the
  /// smart model in the database.
  Future<void> updatePropertyValue({
    required String modelId,
    required String propertyName,
    required dynamic value,
  }) async {
    final smartModels = Map<String, SmartModel>.from(_smartModelsSubject.value);
    final smartModel = smartModels[modelId];
    if (smartModel == null) return;

    final updatedModel = smartModel.updatePropertyValue(propertyName, value);

    smartModels[modelId] = updatedModel;

    _smartModelsSubject.add(smartModels);

    await _smartModelRepository.insertOrUpdateSmartModel(updatedModel);
  }

  /// Adds or updates a smart model and updates the database and the
  /// smart models stream.
  Future<void> addOrUpdateSmartModel(SmartModel smartModel) async {
    final smartModels = Map<String, SmartModel>.from(_smartModelsSubject.value);
    smartModels[smartModel.id] = smartModel;
    _smartModelsSubject.add(smartModels);

    await _smartModelRepository.insertOrUpdateSmartModel(smartModel);
  }

  /// Deletes a smart model and updates the database and the
  /// smart models stream.
  Future<void> deleteSmartModel(SmartModel smartModel) async {
    final smartModels = Map<String, SmartModel>.from(_smartModelsSubject.value);
    smartModels.remove(smartModel.id);
    _smartModelsSubject.add(smartModels);

    await _smartModelRepository.deleteSmartModel(smartModel.id);
  }

  /// Adds or updates a routine and updates the database and the
  /// routines stream.
  Future<void> addOrUpdateRoutine(Routine routine) async {
    final routines = Map<String, Routine>.from(_routinesSubject.value);
    routines[routine.id] = routine;
    _routinesSubject.add(routines);
    await _smartModelRepository.insertOrUpdateRoutine(routine);
    await _setupRoutineAutomation();
  }

  /// Deletes a routine and updates the database and the routines stream.
  Future<void> deleteRoutine(Routine routine) async {
    final routines = Map<String, Routine>.from(_routinesSubject.value);
    routines.remove(routine.id);
    _routinesSubject.add(routines);

    await _smartModelRepository.deleteRoutine(routine.id);
  }

  /// Clears the database and resets the smart models and routines streams.
  Future<void> clear() async {
    await _smartModelRepository.clearDatabase();

    _smartModelsSubject.add({});
    _routinesSubject.add({});
  }

  /// Returns the smart model with the given id.
  SmartModel getSmartModel(String modelId) {
    final smartModels = _smartModelsSubject.value;
    return smartModels[modelId]!;
  }

  /// Disposes the streams and the repository and closes the database.
  /// This method is annotated with `@disposeMethod`, which tells the
  /// dependency injection container to call this method when the service
  /// is disposed.
  @disposeMethod
  Future<void> dispose() async {
    await _smartModelsSubject.close();
    await _routinesSubject.close();
    await _smartModelRepository.dispose();
  }
}

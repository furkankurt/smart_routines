import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smart_routines/app/data/models/routine/routine.dart';
import 'package:smart_routines/app/data/models/smart_model/smart_model.dart';
import 'package:smart_routines/app/data/services/routine_service.dart';

part 'routines_cubit.freezed.dart';
part 'routines_state.dart';

/// [RoutinesCubit] is a [Cubit] that manages the state of the routines page.
/// It is responsible for loading the routines and smart models from the
/// database and updating the state of the routines page.
/// The cubit listens to changes in the routines and smart models streams and
/// emits the corresponding states to the UI. It also provides methods to add,
/// update, and delete routines in the database.
///
/// The cubit is created using the [LazySingleton] annotation from the
/// [injectable](https://pub.dev/packages/injectable) package. This annotation
/// tells the dependency injection container to create a single instance of
/// the cubit and to reuse that instance whenever it is needed.
///
@lazySingleton
class RoutinesCubit extends Cubit<RoutinesState> {
  RoutinesCubit(this._routineService) : super(const RoutinesState.initial());

  final RoutineService _routineService;

  void load() {
    emit(const RoutinesState.loading());

    CombineLatestStream.combine2(
      _routineService.routinesStream,
      _routineService.smartModelsStream,
      (Map<String, Routine> routines, Map<String, SmartModel> smartModels) {
        return RoutinesState.loaded(
          routines.values.toList(),
          smartModels.values.toList(),
        );
      },
    ).listen(emit);
  }

  Future<void> addOrUpdateRoutine(Routine routine) async {
    await _routineService.addOrUpdateRoutine(routine);
  }

  SmartModel getSmartModel(String id) {
    return _routineService.getSmartModel(id);
  }

  Future<void> deleteRoutine(Routine routine) =>
      _routineService.deleteRoutine(routine);
}

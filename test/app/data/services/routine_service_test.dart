import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_routines/app/data/models/condition.dart';
import 'package:smart_routines/app/data/models/routine/routine.dart';
import 'package:smart_routines/app/data/models/smart_model/smart_model.dart';
import 'package:smart_routines/app/data/services/routine_service.dart';
import 'package:smart_routines/app/domain/repositories/smart_model_repository.dart';

import '../../../fixtures/json_fixtures.dart';

class MockSmartModelRepository extends Mock implements SmartModelRepository {}

class MockSmartModel extends Mock implements SmartModel {}

class MockRoutine extends Mock implements Routine {}

void main() {
  late RoutineService routineService;
  late MockSmartModelRepository mockSmartModelRepository;
  final mockSmartModel = SmartModel.fromJson(smartModelJson);
  final mockRoutine = Routine.fromJson(routineJson);

  group('RoutineService', () {
    setUp(() async {
      mockSmartModelRepository = MockSmartModelRepository();
      routineService = RoutineService(mockSmartModelRepository);

      when(() => mockSmartModelRepository.getSmartModels())
          .thenAnswer((_) async => [mockSmartModel]);
      when(() => mockSmartModelRepository.getRoutines())
          .thenAnswer((_) async => [mockRoutine]);

      await routineService.initializeData();
    });

    test('initializeData calls _loadModelsFromDb and _listenDeviceChanges',
        () async {
      when(() => mockSmartModelRepository.getSmartModels())
          .thenAnswer((_) async => []);
      when(() => mockSmartModelRepository.getRoutines())
          .thenAnswer((_) async => []);

      await routineService.initializeData();

      verify(() => mockSmartModelRepository.getSmartModels()).called(2);
      verify(() => mockSmartModelRepository.getRoutines()).called(2);
    });

    test('addOrUpdateSmartModel updates the smart model and repository',
        () async {
      when(
        () => mockSmartModelRepository.insertOrUpdateSmartModel(mockSmartModel),
      ).thenAnswer((_) async {});

      await routineService.addOrUpdateSmartModel(mockSmartModel);

      verify(
        () => mockSmartModelRepository.insertOrUpdateSmartModel(mockSmartModel),
      ).called(1);
    });

    test('deleteSmartModel removes the smart model and updates repository',
        () async {
      when(() => mockSmartModelRepository.deleteSmartModel(mockSmartModel.id))
          .thenAnswer((_) async {});

      await routineService.deleteSmartModel(mockSmartModel);

      verify(() => mockSmartModelRepository.deleteSmartModel(mockSmartModel.id))
          .called(1);
    });

    test('addOrUpdateRoutine updates the routine and repository', () async {
      when(() => mockSmartModelRepository.insertOrUpdateRoutine(mockRoutine))
          .thenAnswer((_) async {});

      await routineService.addOrUpdateRoutine(mockRoutine);

      verify(() => mockSmartModelRepository.insertOrUpdateRoutine(mockRoutine))
          .called(1);
    });

    test('deleteRoutine removes the routine and updates repository', () async {
      when(() => mockSmartModelRepository.deleteRoutine(mockRoutine.id))
          .thenAnswer((_) async {});

      await routineService.deleteRoutine(mockRoutine);

      verify(() => mockSmartModelRepository.deleteRoutine(mockRoutine.id))
          .called(1);
    });

    test('clear clears the database and subjects', () async {
      when(() => mockSmartModelRepository.clearDatabase())
          .thenAnswer((_) async {});

      await routineService.clear();

      verify(() => mockSmartModelRepository.clearDatabase()).called(1);
      expect(routineService.smartModelsStream, emits({}));
      expect(routineService.routinesStream, emits({}));
    });

    test('getSmartModel returns the smart model', () {
      final result = routineService.getSmartModel(mockSmartModel.id);

      expect(result, mockSmartModel);
    });

    test('dispose closes the subjects and disposes the repository', () async {
      when(() => mockSmartModelRepository.dispose()).thenAnswer((_) async {});

      await routineService.dispose();

      verify(() => mockSmartModelRepository.dispose()).called(1);
    });
  });

  group('RoutineService Automations', () {
    setUp(() async {
      mockSmartModelRepository = MockSmartModelRepository();
      routineService = RoutineService(mockSmartModelRepository);

      when(() => mockSmartModelRepository.getSmartModels()).thenAnswer(
        (_) async => [
          mockSmartModel.copyWith(
            id: 'smart-trigger-id',
            properties: [
              mockSmartModel.properties[0].copyWith(
                modelId: 'smart-trigger-id',
                name: 'power',
                value: false,
              ),
            ],
          ),
          mockSmartModel.copyWith(
            id: 'smart-action-id',
            properties: [
              mockSmartModel.properties[0].copyWith(
                modelId: 'smart-action-id',
                name: 'brightness',
                value: 50,
              ),
            ],
          ),
        ],
      );

      when(() => mockSmartModelRepository.getRoutines()).thenAnswer(
        (_) async => [
          mockRoutine.copyWith(
            trigger: mockRoutine.trigger.copyWith(
              modelId: 'smart-trigger-id',
              propertyName: 'power',
              condition: Condition.equals,
              value: true,
            ),
            actions: [
              mockRoutine.actions[0].copyWith(
                modelId: 'smart-action-id',
                propertyName: 'brightness',
                value: 100,
              ),
            ],
          ),
        ],
      );

      registerFallbackValue(mockSmartModel);
    });

    test('setupRoutineAutomation sets up the routine automation', () async {
      await routineService.initializeData();

      when(() => mockSmartModelRepository.insertOrUpdateSmartModel(any()))
          .thenAnswer((_) async {});

      await routineService.updatePropertyValue(
        modelId: 'smart-trigger-id',
        propertyName: 'power',
        value: true,
      );

      await untilCalled(
        () => mockSmartModelRepository.insertOrUpdateSmartModel(any()),
      );

      final updatedModel = routineService.getSmartModel('smart-action-id');

      verify(
        () => mockSmartModelRepository.insertOrUpdateSmartModel(updatedModel),
      ).called(1);
      expect(updatedModel.properties[0].value, 100);
    });
  });
}

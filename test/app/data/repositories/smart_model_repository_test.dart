import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_routines/app/data/database/app_database.dart';
import 'package:smart_routines/app/data/models/routine/routine.dart';
import 'package:smart_routines/app/data/models/smart_model/smart_model.dart';
import 'package:smart_routines/app/data/repositories/smart_model_repository_impl.dart';

import '../../../fixtures/json_fixtures.dart';

void main() {
  late SmartModelRepositoryImpl repository;
  late AppDatabase db;
  final mockSmartModel = SmartModel.fromJson(smartModelJson);
  final mockRoutine = Routine.fromJson(routineJson);

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    db = AppDatabase(NativeDatabase.memory());
    repository = SmartModelRepositoryImpl(db);
  });

  tearDownAll(() async {
    await db.close();
  });

  group('SmartModelRepositoryImpl', () {
    test('getSmartModels returns list of SmartModels', () async {
      final result = await repository.getSmartModels();

      expect(result, isA<List<SmartModel>>());
      expect(result.first.name, 'Bedroom Light');
    });

    test('getRoutines returns list of Routines', () async {
      final result = await repository.getRoutines();

      expect(result, isA<List<Routine>>());
      expect(result.first.name, 'Wake Up');
    });

    test('insertOrUpdateSmartModel inserts or updates a SmartModel', () async {
      final oldResult = await repository.getSmartModels();

      expect(oldResult.length, 7);

      await repository
          .insertOrUpdateSmartModel(mockSmartModel.copyWith(id: 'new-id'));

      final newResult = await repository.getSmartModels();

      expect(newResult.length, 8);
    });

    test('updateModelProperty updates a property', () async {
      await repository.updateModelProperty(
        mockSmartModel.properties.first.copyWith(value: 'true'),
      );

      final result = await repository.getSmartModels();

      final property = result.first.properties.first;

      expect(property.value, true);
    });

    test('insertOrUpdateRoutine inserts or updates a Routine', () async {
      await repository.insertOrUpdateRoutine(
        mockRoutine.copyWith(name: 'Sleep'),
      );

      final result = await repository.getRoutines();

      expect(result.first.name, 'Sleep');
    });

    test('deleteSmartModel deletes a SmartModel', () async {
      await repository.deleteSmartModel(mockSmartModel.id);

      final result = await repository.getSmartModels();

      expect(result.first.id, isNot(mockSmartModel.id));
    });

    test('deleteRoutine deletes a Routine', () async {
      await repository.deleteRoutine(mockRoutine.id);

      final result = await repository.getRoutines();

      expect(result.first.id, isNot(mockRoutine.id));
    });

    test('clearDatabase clears the database', () async {
      await repository.clearDatabase();

      final smartModels = await repository.getSmartModels();
      final routines = await repository.getRoutines();

      expect(smartModels.length, 0);
      expect(routines.length, 0);
    });

    test('dispose closes the database', () async {
      await repository.dispose();

      try {
        await repository.getSmartModels();
      } catch (e) {
        expect(e, isA<StateError>());
      }
    });
  });
}

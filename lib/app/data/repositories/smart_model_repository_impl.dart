import 'package:injectable/injectable.dart';
import 'package:smart_routines/app/data/database/app_database.dart';
import 'package:smart_routines/app/data/models/property/property.dart';
import 'package:smart_routines/app/data/models/routine/routine.dart';
import 'package:smart_routines/app/data/models/smart_model/smart_model.dart';
import 'package:smart_routines/app/domain/repositories/smart_model_repository.dart';

/// [SmartModelRepositoryImpl] is the implementation of the
/// [SmartModelRepository] interface. It is responsible for interacting
/// with the database to get and update the smart models and routines.
///
/// The repository is created using the [LazySingleton] annotation from the
/// [injectable](https://pub.dev/packages/injectable) package. This annotation
/// tells the dependency injection container to create a single instance of
/// the repository and to reuse that instance whenever it is needed.
///
/// The repository takes an instance of the [AppDatabase] as a parameter in
/// its constructor. This allows the repository to interact with the database
/// to get and update the smart models and routines.
///
/// The repository implements the [SmartModelRepository] interface, which
/// defines the methods for getting and updating the smart models and routines.
///
@LazySingleton(as: SmartModelRepository)
class SmartModelRepositoryImpl implements SmartModelRepository {
  const SmartModelRepositoryImpl(this._db);
  final AppDatabase _db;

  @override
  Future<List<SmartModel>> getSmartModels() async {
    final models = await _db.select(_db.smartModels).get();
    final properties = await _db.select(_db.modelProperties).get();

    return models.map((smartModel) {
      return SmartModel.fromDb(
        smartModel.id,
        smartModel.name,
        smartModel.type,
        smartModel.lastUpdated,
        smartModel.isActive,
      ).copyWith(
        properties:
            properties.where((p) => p.modelId == smartModel.id).toList(),
      );
    }).toList();
  }

  @override
  Future<List<Routine>> getRoutines() => _db.select(_db.routines).get();

  @override
  Future<void> insertOrUpdateSmartModel(SmartModel smartModel) async {
    await _db
        .into(_db.smartModels)
        .insertOnConflictUpdate(smartModel.toCompanion());
    await _db.batch(
      (b) => b.insertAllOnConflictUpdate(
        _db.modelProperties,
        smartModel.properties.map((p) => p.toCompanion()),
      ),
    );
  }

  @override
  Future<void> updateModelProperty(Property property) async {
    await (_db.update(_db.modelProperties)
          ..where((tbl) => tbl.id.equals(property.id)))
        .write(property.toCompanion());
  }

  @override
  Future<void> insertOrUpdateRoutine(Routine routine) async {
    await _db.into(_db.routines).insertOnConflictUpdate(routine.toCompanion());
  }

  @override
  Future<void> deleteSmartModel(String id) async {
    await (_db.delete(_db.smartModels)..where((tbl) => tbl.id.equals(id))).go();
    await (_db.delete(_db.modelProperties)
          ..where((tbl) => tbl.modelId.equals(id)))
        .go();
  }

  @override
  Future<void> deleteRoutine(String id) async {
    await (_db.delete(_db.routines)..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<void> clearDatabase() async {
    await _db.delete(_db.smartModels).go();
    await _db.delete(_db.modelProperties).go();
    await _db.delete(_db.routines).go();
  }

  @disposeMethod
  @override
  Future<void> dispose() async {
    await _db.close();
  }
}

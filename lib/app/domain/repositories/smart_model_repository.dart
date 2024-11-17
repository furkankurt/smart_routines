import 'package:smart_routines/app/data/models/property/property.dart';
import 'package:smart_routines/app/data/models/routine/routine.dart';
import 'package:smart_routines/app/data/models/smart_model/smart_model.dart';

abstract class SmartModelRepository {
  /// Gets all smart models from the database.
  Future<List<SmartModel>> getSmartModels();

  /// Gets all routines from the database.
  Future<List<Routine>> getRoutines();

  /// Inserts or updates a smart model in the database.
  Future<void> insertOrUpdateSmartModel(SmartModel smartModel);

  /// Updates a model property in the database.
  Future<void> updateModelProperty(Property property);

  /// Inserts or updates a routine in the database.
  Future<void> insertOrUpdateRoutine(Routine routine);

  /// Deletes a smart model from the database.
  Future<void> deleteSmartModel(String modelId);

  /// Deletes a routine from the database.
  Future<void> deleteRoutine(String routineId);

  /// Clears the database.
  Future<void> clearDatabase();

  /// Closes the database connection.
  Future<void> dispose();
}

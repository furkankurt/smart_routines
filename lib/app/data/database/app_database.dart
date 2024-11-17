import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_routines/app/data/models/property/property.dart';
import 'package:smart_routines/app/data/models/routine/routine.dart';
import 'package:smart_routines/app/data/models/smart_model/smart_model.dart';

part 'app_database.g.dart';
part 'tables.dart';

/// [AppDatabase] is the main database that will be used as the main source of
/// data for the application. It will be used to store the smart models and
/// routines that the user has created.
///
/// The database is created using the [drift](https://pub.dev/packages/drift)
/// package, which is a SQL database abstraction layer for Dart and Flutter.
/// The database is created using the [DriftDatabase] annotation,
/// which takes a list of tables that will be created in the database.
///
/// When the database is created, it will create the tables in the database
/// and seed the database with some mock data. The mock data is loaded from
/// JSON files that are stored in the assets folder of the application.
///
@lazySingleton
@DriftDatabase(tables: [SmartModels, ModelProperties, Routines])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _seedDatabase();
        },
      );

  Future<void> _seedDatabase() async {
    final mockSmartModels = await _getMockSmartModels();
    final mockRoutines = await _getMockRoutines();
    await batch((b) {
      b.insertAllOnConflictUpdate(
        smartModels,
        mockSmartModels.map((e) => e.toCompanion()),
      );
      b.insertAllOnConflictUpdate(
        modelProperties,
        mockSmartModels.expand((e) => e.properties).map((e) => e.toCompanion()),
      );
      b.insertAllOnConflictUpdate(
        routines,
        mockRoutines.map((e) => e.toCompanion()),
      );
    });
  }

  Future<List<SmartModel>> _getMockSmartModels() async {
    const smartModelsLocations = 'assets/fixtures/smart_models.json';
    final data = await rootBundle.loadString(smartModelsLocations);
    final json = jsonDecode(data) as List<dynamic>;
    return json
        .map((e) => SmartModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Routine>> _getMockRoutines() async {
    const routinesLocation = 'assets/fixtures/routines.json';
    final data = await rootBundle.loadString(routinesLocation);
    final json = jsonDecode(data) as List<dynamic>;
    return json
        .map((e) => Routine.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

// coverage:ignore-start
@module
abstract class LazyDatabaseInjectionModule {
  @LazySingleton(as: QueryExecutor)
  LazyDatabase openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(join(dbFolder.path, 'db.sqlite'));
      return NativeDatabase(file);
    });
  }
}
// coverage:ignore-end

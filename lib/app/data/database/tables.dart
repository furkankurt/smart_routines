// coverage:ignore-file
part of 'app_database.dart';

@UseRowClass(SmartModel, constructor: 'fromDb')
class SmartModels extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get type => textEnum<ModelType>()();
  BoolColumn get isActive => boolean()();
  DateTimeColumn get lastUpdated => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@UseRowClass(Property, constructor: 'fromDb')
class ModelProperties extends Table {
  TextColumn get id => text()();
  TextColumn get modelId => text().references(SmartModels, #id)();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get value => text()();
  TextColumn get supportedConditions => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@UseRowClass(Routine, constructor: 'fromDb')
class Routines extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get trigger => text()();
  TextColumn get actions => text()();
  BoolColumn get isActive => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}

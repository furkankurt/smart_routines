// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SmartModelsTable extends SmartModels
    with TableInfo<$SmartModelsTable, SmartModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SmartModelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<ModelType, String> type =
      GeneratedColumn<String>('type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<ModelType>($SmartModelsTable.$convertertype);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'));
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
      'last_updated', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, type, isActive, lastUpdated];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'smart_models';
  @override
  VerificationContext validateIntegrity(Insertable<SmartModel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    } else if (isInserting) {
      context.missing(_isActiveMeta);
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SmartModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SmartModel.fromDb(
      attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      $SmartModelsTable.$convertertype.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!),
      attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
      attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $SmartModelsTable createAlias(String alias) {
    return $SmartModelsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ModelType, String, String> $convertertype =
      const EnumNameConverter<ModelType>(ModelType.values);
}

class SmartModelsCompanion extends UpdateCompanion<SmartModel> {
  final Value<String> id;
  final Value<String> name;
  final Value<ModelType> type;
  final Value<bool> isActive;
  final Value<DateTime> lastUpdated;
  final Value<int> rowid;
  const SmartModelsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.isActive = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SmartModelsCompanion.insert({
    required String id,
    required String name,
    required ModelType type,
    required bool isActive,
    required DateTime lastUpdated,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        type = Value(type),
        isActive = Value(isActive),
        lastUpdated = Value(lastUpdated);
  static Insertable<SmartModel> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<bool>? isActive,
    Expression<DateTime>? lastUpdated,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (isActive != null) 'is_active': isActive,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SmartModelsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<ModelType>? type,
      Value<bool>? isActive,
      Value<DateTime>? lastUpdated,
      Value<int>? rowid}) {
    return SmartModelsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      isActive: isActive ?? this.isActive,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] =
          Variable<String>($SmartModelsTable.$convertertype.toSql(type.value));
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SmartModelsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('isActive: $isActive, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ModelPropertiesTable extends ModelProperties
    with TableInfo<$ModelPropertiesTable, Property> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ModelPropertiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _modelIdMeta =
      const VerificationMeta('modelId');
  @override
  late final GeneratedColumn<String> modelId = GeneratedColumn<String>(
      'model_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES smart_models (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _supportedConditionsMeta =
      const VerificationMeta('supportedConditions');
  @override
  late final GeneratedColumn<String> supportedConditions =
      GeneratedColumn<String>('supported_conditions', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, modelId, name, description, value, supportedConditions];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'model_properties';
  @override
  VerificationContext validateIntegrity(Insertable<Property> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('model_id')) {
      context.handle(_modelIdMeta,
          modelId.isAcceptableOrUnknown(data['model_id']!, _modelIdMeta));
    } else if (isInserting) {
      context.missing(_modelIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('supported_conditions')) {
      context.handle(
          _supportedConditionsMeta,
          supportedConditions.isAcceptableOrUnknown(
              data['supported_conditions']!, _supportedConditionsMeta));
    } else if (isInserting) {
      context.missing(_supportedConditionsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Property map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Property.fromDb(
      attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}model_id'])!,
      attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
      attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}supported_conditions'])!,
    );
  }

  @override
  $ModelPropertiesTable createAlias(String alias) {
    return $ModelPropertiesTable(attachedDatabase, alias);
  }
}

class ModelPropertiesCompanion extends UpdateCompanion<Property> {
  final Value<String> id;
  final Value<String> modelId;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> value;
  final Value<String> supportedConditions;
  final Value<int> rowid;
  const ModelPropertiesCompanion({
    this.id = const Value.absent(),
    this.modelId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.value = const Value.absent(),
    this.supportedConditions = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ModelPropertiesCompanion.insert({
    required String id,
    required String modelId,
    required String name,
    this.description = const Value.absent(),
    required String value,
    required String supportedConditions,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        modelId = Value(modelId),
        name = Value(name),
        value = Value(value),
        supportedConditions = Value(supportedConditions);
  static Insertable<Property> custom({
    Expression<String>? id,
    Expression<String>? modelId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? value,
    Expression<String>? supportedConditions,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (modelId != null) 'model_id': modelId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (value != null) 'value': value,
      if (supportedConditions != null)
        'supported_conditions': supportedConditions,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ModelPropertiesCompanion copyWith(
      {Value<String>? id,
      Value<String>? modelId,
      Value<String>? name,
      Value<String?>? description,
      Value<String>? value,
      Value<String>? supportedConditions,
      Value<int>? rowid}) {
    return ModelPropertiesCompanion(
      id: id ?? this.id,
      modelId: modelId ?? this.modelId,
      name: name ?? this.name,
      description: description ?? this.description,
      value: value ?? this.value,
      supportedConditions: supportedConditions ?? this.supportedConditions,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (modelId.present) {
      map['model_id'] = Variable<String>(modelId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (supportedConditions.present) {
      map['supported_conditions'] = Variable<String>(supportedConditions.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModelPropertiesCompanion(')
          ..write('id: $id, ')
          ..write('modelId: $modelId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('value: $value, ')
          ..write('supportedConditions: $supportedConditions, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RoutinesTable extends Routines with TableInfo<$RoutinesTable, Routine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _triggerMeta =
      const VerificationMeta('trigger');
  @override
  late final GeneratedColumn<String> trigger = GeneratedColumn<String>(
      'trigger', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _actionsMeta =
      const VerificationMeta('actions');
  @override
  late final GeneratedColumn<String> actions = GeneratedColumn<String>(
      'actions', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [id, name, trigger, actions, isActive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routines';
  @override
  VerificationContext validateIntegrity(Insertable<Routine> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('trigger')) {
      context.handle(_triggerMeta,
          trigger.isAcceptableOrUnknown(data['trigger']!, _triggerMeta));
    } else if (isInserting) {
      context.missing(_triggerMeta);
    }
    if (data.containsKey('actions')) {
      context.handle(_actionsMeta,
          actions.isAcceptableOrUnknown(data['actions']!, _actionsMeta));
    } else if (isInserting) {
      context.missing(_actionsMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    } else if (isInserting) {
      context.missing(_isActiveMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Routine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Routine.fromDb(
      attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}trigger'])!,
      attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}actions'])!,
      attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $RoutinesTable createAlias(String alias) {
    return $RoutinesTable(attachedDatabase, alias);
  }
}

class RoutinesCompanion extends UpdateCompanion<Routine> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> trigger;
  final Value<String> actions;
  final Value<bool> isActive;
  final Value<int> rowid;
  const RoutinesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.trigger = const Value.absent(),
    this.actions = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoutinesCompanion.insert({
    required String id,
    required String name,
    required String trigger,
    required String actions,
    required bool isActive,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        trigger = Value(trigger),
        actions = Value(actions),
        isActive = Value(isActive);
  static Insertable<Routine> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? trigger,
    Expression<String>? actions,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (trigger != null) 'trigger': trigger,
      if (actions != null) 'actions': actions,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoutinesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? trigger,
      Value<String>? actions,
      Value<bool>? isActive,
      Value<int>? rowid}) {
    return RoutinesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      trigger: trigger ?? this.trigger,
      actions: actions ?? this.actions,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (trigger.present) {
      map['trigger'] = Variable<String>(trigger.value);
    }
    if (actions.present) {
      map['actions'] = Variable<String>(actions.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutinesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('trigger: $trigger, ')
          ..write('actions: $actions, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SmartModelsTable smartModels = $SmartModelsTable(this);
  late final $ModelPropertiesTable modelProperties =
      $ModelPropertiesTable(this);
  late final $RoutinesTable routines = $RoutinesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [smartModels, modelProperties, routines];
}

typedef $$SmartModelsTableCreateCompanionBuilder = SmartModelsCompanion
    Function({
  required String id,
  required String name,
  required ModelType type,
  required bool isActive,
  required DateTime lastUpdated,
  Value<int> rowid,
});
typedef $$SmartModelsTableUpdateCompanionBuilder = SmartModelsCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<ModelType> type,
  Value<bool> isActive,
  Value<DateTime> lastUpdated,
  Value<int> rowid,
});

final class $$SmartModelsTableReferences
    extends BaseReferences<_$AppDatabase, $SmartModelsTable, SmartModel> {
  $$SmartModelsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ModelPropertiesTable, List<Property>>
      _modelPropertiesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.modelProperties,
              aliasName: $_aliasNameGenerator(
                  db.smartModels.id, db.modelProperties.modelId));

  $$ModelPropertiesTableProcessedTableManager get modelPropertiesRefs {
    final manager =
        $$ModelPropertiesTableTableManager($_db, $_db.modelProperties)
            .filter((f) => f.modelId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_modelPropertiesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SmartModelsTableFilterComposer
    extends Composer<_$AppDatabase, $SmartModelsTable> {
  $$SmartModelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<ModelType, ModelType, String> get type =>
      $composableBuilder(
          column: $table.type,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnFilters(column));

  Expression<bool> modelPropertiesRefs(
      Expression<bool> Function($$ModelPropertiesTableFilterComposer f) f) {
    final $$ModelPropertiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.modelProperties,
        getReferencedColumn: (t) => t.modelId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ModelPropertiesTableFilterComposer(
              $db: $db,
              $table: $db.modelProperties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SmartModelsTableOrderingComposer
    extends Composer<_$AppDatabase, $SmartModelsTable> {
  $$SmartModelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnOrderings(column));
}

class $$SmartModelsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SmartModelsTable> {
  $$SmartModelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ModelType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => column);

  Expression<T> modelPropertiesRefs<T extends Object>(
      Expression<T> Function($$ModelPropertiesTableAnnotationComposer a) f) {
    final $$ModelPropertiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.modelProperties,
        getReferencedColumn: (t) => t.modelId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ModelPropertiesTableAnnotationComposer(
              $db: $db,
              $table: $db.modelProperties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SmartModelsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SmartModelsTable,
    SmartModel,
    $$SmartModelsTableFilterComposer,
    $$SmartModelsTableOrderingComposer,
    $$SmartModelsTableAnnotationComposer,
    $$SmartModelsTableCreateCompanionBuilder,
    $$SmartModelsTableUpdateCompanionBuilder,
    (SmartModel, $$SmartModelsTableReferences),
    SmartModel,
    PrefetchHooks Function({bool modelPropertiesRefs})> {
  $$SmartModelsTableTableManager(_$AppDatabase db, $SmartModelsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SmartModelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SmartModelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SmartModelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<ModelType> type = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> lastUpdated = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SmartModelsCompanion(
            id: id,
            name: name,
            type: type,
            isActive: isActive,
            lastUpdated: lastUpdated,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required ModelType type,
            required bool isActive,
            required DateTime lastUpdated,
            Value<int> rowid = const Value.absent(),
          }) =>
              SmartModelsCompanion.insert(
            id: id,
            name: name,
            type: type,
            isActive: isActive,
            lastUpdated: lastUpdated,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SmartModelsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({modelPropertiesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (modelPropertiesRefs) db.modelProperties
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (modelPropertiesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$SmartModelsTableReferences
                            ._modelPropertiesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SmartModelsTableReferences(db, table, p0)
                                .modelPropertiesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.modelId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SmartModelsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SmartModelsTable,
    SmartModel,
    $$SmartModelsTableFilterComposer,
    $$SmartModelsTableOrderingComposer,
    $$SmartModelsTableAnnotationComposer,
    $$SmartModelsTableCreateCompanionBuilder,
    $$SmartModelsTableUpdateCompanionBuilder,
    (SmartModel, $$SmartModelsTableReferences),
    SmartModel,
    PrefetchHooks Function({bool modelPropertiesRefs})>;
typedef $$ModelPropertiesTableCreateCompanionBuilder = ModelPropertiesCompanion
    Function({
  required String id,
  required String modelId,
  required String name,
  Value<String?> description,
  required String value,
  required String supportedConditions,
  Value<int> rowid,
});
typedef $$ModelPropertiesTableUpdateCompanionBuilder = ModelPropertiesCompanion
    Function({
  Value<String> id,
  Value<String> modelId,
  Value<String> name,
  Value<String?> description,
  Value<String> value,
  Value<String> supportedConditions,
  Value<int> rowid,
});

final class $$ModelPropertiesTableReferences
    extends BaseReferences<_$AppDatabase, $ModelPropertiesTable, Property> {
  $$ModelPropertiesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $SmartModelsTable _modelIdTable(_$AppDatabase db) =>
      db.smartModels.createAlias(
          $_aliasNameGenerator(db.modelProperties.modelId, db.smartModels.id));

  $$SmartModelsTableProcessedTableManager? get modelId {
    if ($_item.modelId == null) return null;
    final manager = $$SmartModelsTableTableManager($_db, $_db.smartModels)
        .filter((f) => f.id($_item.modelId!));
    final item = $_typedResult.readTableOrNull(_modelIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ModelPropertiesTableFilterComposer
    extends Composer<_$AppDatabase, $ModelPropertiesTable> {
  $$ModelPropertiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get supportedConditions => $composableBuilder(
      column: $table.supportedConditions,
      builder: (column) => ColumnFilters(column));

  $$SmartModelsTableFilterComposer get modelId {
    final $$SmartModelsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.modelId,
        referencedTable: $db.smartModels,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SmartModelsTableFilterComposer(
              $db: $db,
              $table: $db.smartModels,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ModelPropertiesTableOrderingComposer
    extends Composer<_$AppDatabase, $ModelPropertiesTable> {
  $$ModelPropertiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get supportedConditions => $composableBuilder(
      column: $table.supportedConditions,
      builder: (column) => ColumnOrderings(column));

  $$SmartModelsTableOrderingComposer get modelId {
    final $$SmartModelsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.modelId,
        referencedTable: $db.smartModels,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SmartModelsTableOrderingComposer(
              $db: $db,
              $table: $db.smartModels,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ModelPropertiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ModelPropertiesTable> {
  $$ModelPropertiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get supportedConditions => $composableBuilder(
      column: $table.supportedConditions, builder: (column) => column);

  $$SmartModelsTableAnnotationComposer get modelId {
    final $$SmartModelsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.modelId,
        referencedTable: $db.smartModels,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SmartModelsTableAnnotationComposer(
              $db: $db,
              $table: $db.smartModels,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ModelPropertiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ModelPropertiesTable,
    Property,
    $$ModelPropertiesTableFilterComposer,
    $$ModelPropertiesTableOrderingComposer,
    $$ModelPropertiesTableAnnotationComposer,
    $$ModelPropertiesTableCreateCompanionBuilder,
    $$ModelPropertiesTableUpdateCompanionBuilder,
    (Property, $$ModelPropertiesTableReferences),
    Property,
    PrefetchHooks Function({bool modelId})> {
  $$ModelPropertiesTableTableManager(
      _$AppDatabase db, $ModelPropertiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ModelPropertiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ModelPropertiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ModelPropertiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> modelId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<String> supportedConditions = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ModelPropertiesCompanion(
            id: id,
            modelId: modelId,
            name: name,
            description: description,
            value: value,
            supportedConditions: supportedConditions,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String modelId,
            required String name,
            Value<String?> description = const Value.absent(),
            required String value,
            required String supportedConditions,
            Value<int> rowid = const Value.absent(),
          }) =>
              ModelPropertiesCompanion.insert(
            id: id,
            modelId: modelId,
            name: name,
            description: description,
            value: value,
            supportedConditions: supportedConditions,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ModelPropertiesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({modelId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (modelId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.modelId,
                    referencedTable:
                        $$ModelPropertiesTableReferences._modelIdTable(db),
                    referencedColumn:
                        $$ModelPropertiesTableReferences._modelIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ModelPropertiesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ModelPropertiesTable,
    Property,
    $$ModelPropertiesTableFilterComposer,
    $$ModelPropertiesTableOrderingComposer,
    $$ModelPropertiesTableAnnotationComposer,
    $$ModelPropertiesTableCreateCompanionBuilder,
    $$ModelPropertiesTableUpdateCompanionBuilder,
    (Property, $$ModelPropertiesTableReferences),
    Property,
    PrefetchHooks Function({bool modelId})>;
typedef $$RoutinesTableCreateCompanionBuilder = RoutinesCompanion Function({
  required String id,
  required String name,
  required String trigger,
  required String actions,
  required bool isActive,
  Value<int> rowid,
});
typedef $$RoutinesTableUpdateCompanionBuilder = RoutinesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> trigger,
  Value<String> actions,
  Value<bool> isActive,
  Value<int> rowid,
});

class $$RoutinesTableFilterComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get trigger => $composableBuilder(
      column: $table.trigger, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get actions => $composableBuilder(
      column: $table.actions, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));
}

class $$RoutinesTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get trigger => $composableBuilder(
      column: $table.trigger, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get actions => $composableBuilder(
      column: $table.actions, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));
}

class $$RoutinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get trigger =>
      $composableBuilder(column: $table.trigger, builder: (column) => column);

  GeneratedColumn<String> get actions =>
      $composableBuilder(column: $table.actions, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$RoutinesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RoutinesTable,
    Routine,
    $$RoutinesTableFilterComposer,
    $$RoutinesTableOrderingComposer,
    $$RoutinesTableAnnotationComposer,
    $$RoutinesTableCreateCompanionBuilder,
    $$RoutinesTableUpdateCompanionBuilder,
    (Routine, BaseReferences<_$AppDatabase, $RoutinesTable, Routine>),
    Routine,
    PrefetchHooks Function()> {
  $$RoutinesTableTableManager(_$AppDatabase db, $RoutinesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoutinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> trigger = const Value.absent(),
            Value<String> actions = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RoutinesCompanion(
            id: id,
            name: name,
            trigger: trigger,
            actions: actions,
            isActive: isActive,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String trigger,
            required String actions,
            required bool isActive,
            Value<int> rowid = const Value.absent(),
          }) =>
              RoutinesCompanion.insert(
            id: id,
            name: name,
            trigger: trigger,
            actions: actions,
            isActive: isActive,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RoutinesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RoutinesTable,
    Routine,
    $$RoutinesTableFilterComposer,
    $$RoutinesTableOrderingComposer,
    $$RoutinesTableAnnotationComposer,
    $$RoutinesTableCreateCompanionBuilder,
    $$RoutinesTableUpdateCompanionBuilder,
    (Routine, BaseReferences<_$AppDatabase, $RoutinesTable, Routine>),
    Routine,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SmartModelsTableTableManager get smartModels =>
      $$SmartModelsTableTableManager(_db, _db.smartModels);
  $$ModelPropertiesTableTableManager get modelProperties =>
      $$ModelPropertiesTableTableManager(_db, _db.modelProperties);
  $$RoutinesTableTableManager get routines =>
      $$RoutinesTableTableManager(_db, _db.routines);
}

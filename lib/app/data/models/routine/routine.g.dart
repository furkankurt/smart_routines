// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Routine _$RoutineFromJson(Map<String, dynamic> json) => Routine(
      name: json['name'] as String,
      trigger: Trigger.fromJson(json['trigger'] as Map<String, dynamic>),
      actions: (json['actions'] as List<dynamic>)
          .map((e) => Action.fromJson(e as Map<String, dynamic>))
          .toList(),
      isActive: json['isActive'] as bool? ?? true,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$RoutineToJson(Routine instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'trigger': instance.trigger.toJson(),
      'actions': instance.actions.map((e) => e.toJson()).toList(),
      'isActive': instance.isActive,
    };

Trigger _$TriggerFromJson(Map<String, dynamic> json) => Trigger(
      modelId: json['modelId'] as String,
      propertyName: json['propertyName'] as String,
      condition: $enumDecode(_$ConditionEnumMap, json['condition']),
      value: _$JsonConverterFromJson<String, dynamic>(
          json['value'], const ValueJsonConverter().fromJson),
    );

Map<String, dynamic> _$TriggerToJson(Trigger instance) => <String, dynamic>{
      'modelId': instance.modelId,
      'propertyName': instance.propertyName,
      'condition': _$ConditionEnumMap[instance.condition]!,
      'value': const ValueJsonConverter().toJson(instance.value),
    };

const _$ConditionEnumMap = {
  Condition.above: 'above',
  Condition.below: 'below',
  Condition.equals: 'equals',
  Condition.notEquals: 'notEquals',
  Condition.contains: 'contains',
  Condition.notContains: 'notContains',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Action _$ActionFromJson(Map<String, dynamic> json) => Action(
      modelId: json['modelId'] as String,
      propertyName: json['propertyName'] as String,
      value: _$JsonConverterFromJson<String, dynamic>(
          json['value'], const ValueJsonConverter().fromJson),
    );

Map<String, dynamic> _$ActionToJson(Action instance) => <String, dynamic>{
      'modelId': instance.modelId,
      'propertyName': instance.propertyName,
      'value': const ValueJsonConverter().toJson(instance.value),
    };

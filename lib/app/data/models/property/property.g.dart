// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Property _$PropertyFromJson(Map<String, dynamic> json) => Property(
      modelId: json['modelId'] as String,
      name: json['name'] as String,
      value: json['value'],
      supportedConditions: (json['supportedConditions'] as List<dynamic>)
          .map((e) => $enumDecode(_$ConditionEnumMap, e))
          .toList(),
      description: json['description'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$PropertyToJson(Property instance) => <String, dynamic>{
      'id': instance.id,
      'modelId': instance.modelId,
      'name': instance.name,
      'description': instance.description,
      'value': instance.value,
      'supportedConditions': instance.supportedConditions
          .map((e) => _$ConditionEnumMap[e]!)
          .toList(),
    };

const _$ConditionEnumMap = {
  Condition.above: 'above',
  Condition.below: 'below',
  Condition.equals: 'equals',
  Condition.notEquals: 'notEquals',
  Condition.contains: 'contains',
  Condition.notContains: 'notContains',
};

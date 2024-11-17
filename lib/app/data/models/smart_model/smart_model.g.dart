// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SmartModel _$SmartModelFromJson(Map<String, dynamic> json) => SmartModel(
      name: json['name'] as String,
      type: $enumDecode(_$ModelTypeEnumMap, json['type']),
      properties: (json['properties'] as List<dynamic>?)
              ?.map((e) => Property.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
      isActive: json['isActive'] as bool? ?? true,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$SmartModelToJson(SmartModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$ModelTypeEnumMap[instance.type]!,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
      'isActive': instance.isActive,
      'properties': instance.properties,
    };

const _$ModelTypeEnumMap = {
  ModelType.device: 'device',
  ModelType.service: 'service',
};

import 'dart:convert';

import 'package:drift/drift.dart' hide Trigger;
import 'package:json_annotation/json_annotation.dart';
import 'package:smart_routines/app/data/database/app_database.dart';
import 'package:smart_routines/app/data/models/condition.dart';
import 'package:smart_routines/core/extensions/string_extension.dart';
import 'package:uuid/uuid.dart';

part 'property.g.dart';

/// Represents a property of a smart model
@JsonSerializable()
class Property {
  Property({
    required this.modelId,
    required this.name,
    required this.value,
    required this.supportedConditions,
    this.description,
    String? id,
  }) : id = id ?? const Uuid().v4();

  /// Creates a property from the values in the database
  factory Property.fromDb(
    String id,
    String modelId,
    String name,
    String? description,
    String value,
    String supportedConditions,
  ) {
    return Property(
      id: id,
      modelId: modelId,
      name: name,
      description: description,
      value: value.toValue(),
      supportedConditions: (jsonDecode(supportedConditions) as List)
          .map(
            (sc) => Condition.values.firstWhere(
              (c) => c.name == sc,
            ),
          )
          .toList(),
    );
  }

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyToJson(this);

  /// The id of this property
  final String id;

  /// The id of the model that this property belongs to
  final String modelId;

  /// The name of this property
  final String name;

  /// A description of this property
  final String? description;

  /// The value of this property can be of any type
  dynamic value;

  /// The conditions that this property supports
  final List<Condition> supportedConditions;

  /// Returns a copy of this property with the provided values
  Property copyWith({
    String? id,
    String? modelId,
    String? name,
    String? description,
    dynamic value,
    List<Condition>? supportedConditions,
  }) {
    return Property(
      id: id ?? this.id,
      modelId: modelId ?? this.modelId,
      name: name ?? this.name,
      description: description ?? this.description,
      value: value,
      supportedConditions: supportedConditions ?? this.supportedConditions,
    );
  }

  /// Returns a companion object of this property for use in the database
  ModelPropertiesCompanion toCompanion() {
    return ModelPropertiesCompanion(
      id: Value(id),
      modelId: Value(modelId),
      name: Value(name),
      description: Value(description),
      value: Value(jsonEncode(value)),
      supportedConditions: Value(
        jsonEncode(supportedConditions.map((c) => c.name).toList()),
      ),
    );
  }

  /// Updates the value of this property
  Property updateValue(dynamic value) {
    return copyWith(value: value);
  }
}

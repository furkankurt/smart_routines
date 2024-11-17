import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smart_routines/app/data/database/app_database.dart';
import 'package:smart_routines/app/data/models/property/property.dart';
import 'package:uuid/uuid.dart';

part 'smart_model.g.dart';

enum ModelType { device, service }

/// Represents a smart model that can be a device or a service
@JsonSerializable()
class SmartModel {
  SmartModel({
    required this.name,
    required this.type,
    this.properties = const [],
    this.lastUpdated,
    this.isActive = true,
    String? id,
  }) : id = id ?? const Uuid().v4();

  /// Creates a smart model from the values in the database
  factory SmartModel.fromDb(
    String id,
    String name,
    ModelType type,
    DateTime? lastUpdated,
    bool isActive,
  ) {
    return SmartModel(
      id: id,
      name: name,
      type: type,
      lastUpdated: lastUpdated,
      isActive: isActive,
    );
  }

  factory SmartModel.fromJson(Map<String, dynamic> json) =>
      _$SmartModelFromJson(json);

  Map<String, dynamic> toJson() => _$SmartModelToJson(this);

  /// The id of this smart model
  final String id;

  /// The name of this smart model
  final String name;

  /// The type of this smart model
  final ModelType type;

  /// The last time this smart model was updated
  final DateTime? lastUpdated;

  /// Whether this smart model is active
  final bool isActive;

  /// The properties of this smart model
  List<Property> properties;

  /// Creates a copy of this smart device with the given fields replaced
  SmartModel copyWith({
    String? id,
    String? name,
    ModelType? type,
    List<Property>? properties,
    DateTime? lastUpdated,
    bool? isActive,
  }) {
    return SmartModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      properties: properties ?? this.properties,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isActive: isActive ?? this.isActive,
    );
  }

  /// Returns a companion object that can be used to insert
  /// this smart model into the database
  SmartModelsCompanion toCompanion() {
    return SmartModelsCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      isActive: Value(isActive),
      lastUpdated: Value(lastUpdated ?? DateTime.now()),
    );
  }

  /// Updates the value of a property in this smart model and returns back
  SmartModel updatePropertyValue(String propertyName, dynamic value) {
    final property = getProperty(propertyName);
    if (property == null) return this;

    final updatedProperty = property.updateValue(value);

    return copyWith(
      lastUpdated: DateTime.now(),
      properties: [
        ...properties.where((p) => p.id != property.id),
        updatedProperty,
      ],
    );
  }

  /// Returns the property with the given name
  Property? getProperty(String propertyName) {
    return properties.firstWhereOrNull((p) => p.name == propertyName);
  }
}

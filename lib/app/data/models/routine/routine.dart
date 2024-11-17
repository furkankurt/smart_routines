import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smart_routines/app/data/database/app_database.dart';
import 'package:smart_routines/app/data/models/condition.dart';
import 'package:smart_routines/app/data/models/smart_model/smart_model.dart';
import 'package:smart_routines/core/extensions/string_extension.dart';
import 'package:uuid/uuid.dart';

part 'routine.g.dart';

/// A smart routine that is triggered by a condition and performs actions
@JsonSerializable(explicitToJson: true)
class Routine {
  Routine({
    required this.name,
    required this.trigger,
    required this.actions,
    this.isActive = true,
    String? id,
  }) : id = id ?? const Uuid().v4();

  /// Creates a routine from the values in the database
  factory Routine.fromDb(
    String id,
    String name,
    String trigger,
    String actions,
    bool isActive,
  ) {
    return Routine(
      id: id,
      name: name,
      trigger: Trigger.fromJson(jsonDecode(trigger) as Map<String, dynamic>),
      actions: (jsonDecode(actions) as List)
          .map((e) => Action.fromJson(e as Map<String, dynamic>))
          .toList(),
      isActive: isActive,
    );
  }

  factory Routine.fromJson(Map<String, dynamic> json) =>
      _$RoutineFromJson(json);

  Map<String, dynamic> toJson() => _$RoutineToJson(this);

  /// The id of this routine
  final String id;

  /// The name of this routine
  final String name;

  /// The trigger that activates this routine
  final Trigger trigger;

  /// The actions that are performed when this routine is activated
  final List<Action> actions;

  /// Whether this routine is active
  final bool isActive;

  /// Creates a copy of this routine with the given values
  Routine copyWith({
    String? id,
    String? name,
    Trigger? trigger,
    List<Action>? actions,
    bool? isActive,
  }) {
    return Routine(
      id: id ?? this.id,
      name: name ?? this.name,
      trigger: trigger ?? this.trigger,
      actions: actions ?? this.actions,
      isActive: isActive ?? this.isActive,
    );
  }

  /// Returns a companion object that can be used to
  /// insert this routine into the database
  RoutinesCompanion toCompanion() {
    return RoutinesCompanion(
      id: Value(id),
      name: Value(name),
      trigger: Value(jsonEncode(trigger.toJson())),
      actions: Value(jsonEncode(actions.map((a) => a.toJson()).toList())),
      isActive: Value(isActive),
    );
  }

  /// Toggles the active state of this routine
  Routine toggleActive() {
    return copyWith(isActive: !isActive);
  }
}

/// A trigger that activates a routine
@JsonSerializable()
class Trigger {
  const Trigger({
    required this.modelId,
    required this.propertyName,
    required this.condition,
    required this.value,
  });

  factory Trigger.fromJson(Map<String, dynamic> json) =>
      _$TriggerFromJson(json);

  Map<String, dynamic> toJson() => _$TriggerToJson(this);

  /// The model id that this trigger is performed on
  final String modelId;

  /// The property that is triggered
  final String propertyName;

  /// The condition that triggers the routine
  final Condition condition;

  /// The value that triggers the routine
  @ValueJsonConverter()
  final dynamic value;

  /// Creates a copy of this trigger with the given values
  Trigger copyWith({
    String? modelId,
    String? propertyName,
    Condition? condition,
    dynamic value,
  }) {
    return Trigger(
      modelId: modelId ?? this.modelId,
      propertyName: propertyName ?? this.propertyName,
      condition: condition ?? this.condition,
      value: value ?? this.value,
    );
  }
}

/// An action that is performed when a routine is activated
@JsonSerializable()
class Action {
  const Action({
    required this.modelId,
    required this.propertyName,
    required this.value,
  });

  factory Action.fromJson(Map<String, dynamic> json) => _$ActionFromJson(json);

  Map<String, dynamic> toJson() => _$ActionToJson(this);

  /// The model id that this action is performed on
  final String modelId;

  /// The property that is set
  final String propertyName;

  /// The value that the property is set to
  @ValueJsonConverter()
  final dynamic value;

  /// Creates a copy of this action with the given values
  Action copyWith({
    String? modelId,
    String? propertyName,
    dynamic value,
  }) {
    return Action(
      modelId: modelId ?? this.modelId,
      propertyName: propertyName ?? this.propertyName,
      value: value ?? this.value,
    );
  }
}

/// A converter that converts a String value to a dynamic value
/// with correct type or converts a dynamic value to a String value
class ValueJsonConverter extends JsonConverter<dynamic, String> {
  const ValueJsonConverter();

  @override
  dynamic fromJson(String json) {
    return json.toValue();
  }

  @override
  String toJson(dynamic object) {
    return jsonEncode(object);
  }
}

extension TriggerX on Trigger? {
  /// Returns a human-readable description of this trigger
  String? toDescription(List<SmartModel> models) {
    if (this == null) return null;
    final model = models.firstWhere((m) => m.id == this!.modelId);
    final property = model.getProperty(this!.propertyName);
    return 'When "${model.name}" ${property?.name} '
        '${this!.condition.name} ${namedValue(this!.value)}';
  }
}

extension ActionX on Action? {
  /// Returns a human-readable description of this action
  String? toDescription(List<SmartModel> models) {
    if (this == null) return null;
    final model = models.firstWhere((m) => m.id == this!.modelId);
    final property = model.getProperty(this!.propertyName);
    return 'Set "${model.name}" ${property?.name} '
        'to ${namedValue(this!.value)}';
  }
}

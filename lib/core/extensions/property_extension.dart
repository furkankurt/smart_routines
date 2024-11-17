import 'package:smart_routines/app/data/models/condition.dart';
import 'package:smart_routines/app/data/models/property/property.dart';
import 'package:smart_routines/app/data/models/routine/routine.dart';

extension PropertyX on Property {
  /// Checks if the property value satisfies the trigger condition
  /// and returns true if it does.
  ///
  /// Returns false if the property value is not of the same type as the
  /// trigger value or if the trigger condition is not supported.
  bool checkTrigger(Trigger trigger) {
    if (value.runtimeType != trigger.value.runtimeType) return false;
    if (!supportedConditions.contains(trigger.condition)) return false;

    return switch (trigger.condition) {
      Condition.above => (value as num) > (trigger.value as num),
      Condition.below => (value as num) < (trigger.value as num),
      Condition.equals => value == trigger.value,
      Condition.notEquals => value != trigger.value,
      Condition.contains => (value as String).contains(trigger.value as String),
      Condition.notContains =>
        !(value as String).contains(trigger.value as String),
    };
  }
}

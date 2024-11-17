import 'package:flutter_test/flutter_test.dart';
import 'package:smart_routines/app/data/models/condition.dart';
import 'package:smart_routines/app/data/models/property/property.dart';
import 'package:smart_routines/app/data/models/routine/routine.dart';
import 'package:smart_routines/core/extensions/property_extension.dart';

void main() {
  group('PropertyX', () {
    final mockProperty = Property(
      name: 'test',
      modelId: 'model-id',
      value: 10,
      supportedConditions: [],
    );

    const mockTrigger = Trigger(
      propertyName: 'test',
      modelId: 'model-id',
      condition: Condition.above,
      value: 5,
    );

    test('checkTrigger returns true for Condition.above', () {
      final property = mockProperty
          .copyWith(value: 10, supportedConditions: [Condition.above]);
      final trigger =
          mockTrigger.copyWith(condition: Condition.above, value: 5);

      expect(property.checkTrigger(trigger), isTrue);
    });

    test('checkTrigger returns false for Condition.above', () {
      final property = mockProperty
          .copyWith(value: 10, supportedConditions: [Condition.above]);
      final trigger =
          mockTrigger.copyWith(condition: Condition.above, value: 15);

      expect(property.checkTrigger(trigger), isFalse);
    });

    test('checkTrigger returns true for Condition.below', () {
      final property = mockProperty
          .copyWith(value: 10, supportedConditions: [Condition.below]);
      final trigger =
          mockTrigger.copyWith(condition: Condition.below, value: 15);

      expect(property.checkTrigger(trigger), isTrue);
    });

    test('checkTrigger returns false for Condition.below', () {
      final property = mockProperty
          .copyWith(value: 10, supportedConditions: [Condition.below]);
      final trigger =
          mockTrigger.copyWith(condition: Condition.below, value: 5);

      expect(property.checkTrigger(trigger), isFalse);
    });

    test('checkTrigger returns true for Condition.equals', () {
      final property = mockProperty
          .copyWith(value: 10, supportedConditions: [Condition.equals]);
      final trigger =
          mockTrigger.copyWith(condition: Condition.equals, value: 10);

      expect(property.checkTrigger(trigger), isTrue);
    });

    test('checkTrigger returns false for Condition.equals', () {
      final property = mockProperty
          .copyWith(value: 10, supportedConditions: [Condition.equals]);
      final trigger =
          mockTrigger.copyWith(condition: Condition.equals, value: 5);

      expect(property.checkTrigger(trigger), isFalse);
    });

    test('checkTrigger returns true for Condition.notEquals', () {
      final property = mockProperty
          .copyWith(value: 10, supportedConditions: [Condition.notEquals]);
      final trigger =
          mockTrigger.copyWith(condition: Condition.notEquals, value: 5);

      expect(property.checkTrigger(trigger), isTrue);
    });

    test('checkTrigger returns false for Condition.notEquals', () {
      final property = mockProperty
          .copyWith(value: 10, supportedConditions: [Condition.notEquals]);
      final trigger =
          mockTrigger.copyWith(condition: Condition.notEquals, value: 10);

      expect(property.checkTrigger(trigger), isFalse);
    });

    test('checkTrigger returns true for Condition.contains', () {
      final property = mockProperty.copyWith(
        value: 'hello world',
        supportedConditions: [Condition.contains],
      );
      final trigger =
          mockTrigger.copyWith(condition: Condition.contains, value: 'hello');

      expect(property.checkTrigger(trigger), isTrue);
    });

    test('checkTrigger returns false for Condition.contains', () {
      final property = mockProperty.copyWith(
        value: 'hello world',
        supportedConditions: [Condition.contains],
      );
      final trigger =
          mockTrigger.copyWith(condition: Condition.contains, value: 'bye');

      expect(property.checkTrigger(trigger), isFalse);
    });

    test('checkTrigger returns true for Condition.notContains', () {
      final property = mockProperty.copyWith(
        value: 'hello world',
        supportedConditions: [Condition.notContains],
      );
      final trigger =
          mockTrigger.copyWith(condition: Condition.notContains, value: 'bye');

      expect(property.checkTrigger(trigger), isTrue);
    });

    test('checkTrigger returns false for Condition.notContains', () {
      final property = mockProperty.copyWith(
        value: 'hello world',
        supportedConditions: [Condition.notContains],
      );
      final trigger = mockTrigger.copyWith(
        condition: Condition.notContains,
        value: 'hello',
      );

      expect(property.checkTrigger(trigger), isFalse);
    });
  });
}

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:smart_routines/app/data/models/condition.dart';
import 'package:smart_routines/app/data/models/property/property.dart';

void main() {
  group('Property', () {
    test('should create a Property instance with required fields', () {
      final property = Property(
        modelId: 'model1',
        name: 'PropertyName',
        value: 'PropertyValue',
        supportedConditions: [Condition.equals],
      );

      expect(property.modelId, 'model1');
      expect(property.name, 'PropertyName');
      expect(property.value, 'PropertyValue');
      expect(property.supportedConditions, [Condition.equals]);
      expect(property.id, isNotNull);
    });

    test('should create a Property instance with optional fields', () {
      final property = Property(
        modelId: 'model1',
        name: 'PropertyName',
        value: 'PropertyValue',
        supportedConditions: [Condition.equals],
        description: 'PropertyDescription',
        id: 'customId',
      );

      expect(property.modelId, 'model1');
      expect(property.name, 'PropertyName');
      expect(property.value, 'PropertyValue');
      expect(property.supportedConditions, [Condition.equals]);
      expect(property.description, 'PropertyDescription');
      expect(property.id, 'customId');
    });

    test('should convert Property to JSON and back', () {
      final property = Property(
        modelId: 'model1',
        name: 'PropertyName',
        value: 'PropertyValue',
        supportedConditions: [Condition.equals],
      );

      final json = property.toJson();
      final newProperty = Property.fromJson(json);

      expect(newProperty.modelId, property.modelId);
      expect(newProperty.name, property.name);
      expect(newProperty.value, property.value);
      expect(newProperty.supportedConditions, property.supportedConditions);
      expect(newProperty.id, property.id);
    });

    test('should update value of Property', () {
      final property = Property(
        modelId: 'model1',
        name: 'PropertyName',
        value: 'PropertyValue',
        supportedConditions: [Condition.equals],
      );

      final updatedProperty = property.updateValue('NewValue');

      expect(updatedProperty.value, 'NewValue');
      expect(updatedProperty.modelId, property.modelId);
      expect(updatedProperty.name, property.name);
      expect(updatedProperty.supportedConditions, property.supportedConditions);
      expect(updatedProperty.id, property.id);
    });

    test('should create Property from database fields', () {
      final property = Property.fromDb(
        'id1',
        'model1',
        'PropertyName',
        'PropertyDescription',
        '0',
        '["equals"]',
      );

      expect(property.id, 'id1');
      expect(property.modelId, 'model1');
      expect(property.name, 'PropertyName');
      expect(property.description, 'PropertyDescription');
      expect(property.value, 0);
      expect(property.supportedConditions, [Condition.equals]);
    });

    test('should convert Property to ModelPropertiesCompanion', () {
      final property = Property(
        modelId: 'model1',
        name: 'PropertyName',
        value: 'PropertyValue',
        supportedConditions: [Condition.equals],
      );

      final companion = property.toCompanion();

      expect(companion.id.value, property.id);
      expect(companion.modelId.value, property.modelId);
      expect(companion.name.value, property.name);
      expect(companion.description.value, property.description);
      expect(companion.value.value, jsonEncode(property.value));
      expect(
        companion.supportedConditions.value,
        jsonEncode(property.supportedConditions.map((c) => c.name).toList()),
      );
    });
  });
}

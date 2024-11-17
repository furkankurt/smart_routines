import 'package:flutter_test/flutter_test.dart';
import 'package:smart_routines/app/data/models/condition.dart';
import 'package:smart_routines/app/data/models/property/property.dart';
import 'package:smart_routines/app/data/models/smart_model/smart_model.dart';

void main() {
  final property = Property(
    id: '123',
    modelId: '123',
    name: 'property1',
    description: 'Property 1',
    value: 'value',
    supportedConditions: [Condition.equals, Condition.notEquals],
  );
  final smartModel = SmartModel(
    name: 'Test Device',
    type: ModelType.device,
    properties: [property],
  );

  group('SmartModel', () {
    test('should create a SmartModel with default values', () {
      expect(smartModel.name, 'Test Device');
      expect(smartModel.type, ModelType.device);
      expect(smartModel.properties, [property]);
      expect(smartModel.isActive, true);
      expect(smartModel.id, isNotEmpty);
    });

    test('should create a SmartModel from JSON', () {
      final json = {
        'id': '123',
        'name': 'Test Device',
        'type': 'device',
        'lastUpdated': null,
        'isActive': true,
        'properties': <Property>[],
      };

      final model = SmartModel.fromJson(json);

      expect(model.id, '123');
      expect(model.name, 'Test Device');
      expect(model.type, ModelType.device);
      expect(model.lastUpdated, null);
      expect(model.isActive, true);
      expect(model.properties, <Property>[]);
    });

    test('should convert a SmartModel to JSON', () {
      final json = smartModel.toJson();

      expect(json['id'], smartModel.id);
      expect(json['name'], 'Test Device');
      expect(json['type'], 'device');
      expect(json['lastUpdated'], null);
      expect(json['isActive'], true);
      expect(json['properties'], [property]);
    });

    test('should update property value', () {
      final updatedModel =
          smartModel.updatePropertyValue('property1', 'newValue');

      expect(updatedModel.lastUpdated, isNotNull);
      expect(updatedModel.properties.first.value, 'newValue');
    });

    test('should return null if property not found', () {
      final property = smartModel.getProperty('nonexistent');

      expect(property, isNull);
    });

    test('should create a copy with updated fields', () {
      final newModel = smartModel.copyWith(name: 'Updated Device');

      expect(newModel.name, 'Updated Device');
      expect(newModel.id, smartModel.id);
    });

    test('should convert to companion', () {
      final companion = smartModel.toCompanion();

      expect(companion.id.value, smartModel.id);
      expect(companion.name.value, 'Test Device');
      expect(companion.type.value, ModelType.device);
      expect(companion.isActive.value, true);
      expect(companion.lastUpdated.value, isNotNull);
    });
  });
}

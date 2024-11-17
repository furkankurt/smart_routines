import 'package:flutter_test/flutter_test.dart';
import 'package:smart_routines/app/data/models/condition.dart';
import 'package:smart_routines/app/data/models/property/property.dart';
import 'package:smart_routines/app/data/models/routine/routine.dart';
import 'package:smart_routines/app/data/models/smart_model/smart_model.dart';

void main() {
  final smartModel = SmartModel(
    id: 'model1',
    name: 'Model 1',
    type: ModelType.device,
    properties: [
      Property(
        id: '123',
        modelId: 'model1',
        name: 'property1',
        description: 'Property 1',
        value: '2',
        supportedConditions: [Condition.equals, Condition.notEquals],
      ),
    ],
  );
  const trigger = Trigger(
    modelId: 'model1',
    propertyName: 'property1',
    condition: Condition.equals,
    value: '0',
  );
  const action = Action(
    modelId: 'model1',
    propertyName: 'property1',
    value: '1',
  );
  final routine = Routine(
    name: 'Test Routine',
    trigger: trigger,
    actions: [action],
  );

  group('Routine', () {
    test('should create a routine with default values', () {
      expect(routine.name, 'Test Routine');
      expect(routine.isActive, true);
      expect(routine.id, isNotEmpty);
    });

    test('should toggle routine active state', () {
      final toggledRoutine = routine.toggleActive();

      expect(toggledRoutine.isActive, false);
    });

    test('should convert routine to JSON and back', () {
      final json = routine.toJson();
      final newRoutine = Routine.fromJson(json);

      expect(newRoutine.name, routine.name);
      expect(newRoutine.id, routine.id);
    });

    test('should create a routine from database values', () {
      final routine = Routine.fromDb(
        'id1',
        'Test Routine',
        '{"modelId":"model1","propertyName":"property1","condition":"equals",'
            '"value":"0"}',
        '[{"modelId":"model1","propertyName":"property1","value":"1"}]',
        true,
      );

      expect(routine.id, 'id1');
      expect(routine.name, 'Test Routine');
      expect(routine.trigger.modelId, 'model1');
      expect(routine.actions.first.modelId, 'model1');
    });

    test('should copy routine with new id', () {
      final newRoutine = routine.copyWith(id: 'newId');

      expect(newRoutine.id, 'newId');
      expect(newRoutine.name, routine.name);
      expect(newRoutine.trigger.modelId, routine.trigger.modelId);
      expect(newRoutine.actions.first.modelId, routine.actions.first.modelId);
    });
  });

  group('Trigger', () {
    test('should convert trigger to JSON and back', () {
      final json = trigger.toJson();
      final newTrigger = Trigger.fromJson(json);

      expect(newTrigger.modelId, trigger.modelId);
      expect(newTrigger.propertyName, trigger.propertyName);
      expect(newTrigger.condition, trigger.condition);
      expect(newTrigger.value, 0);
    });

    test('should update trigger value', () {
      final updatedTrigger = trigger.copyWith(value: 2);

      expect(updatedTrigger.value, 2);
      expect(updatedTrigger.modelId, trigger.modelId);
      expect(updatedTrigger.propertyName, trigger.propertyName);
      expect(updatedTrigger.condition, trigger.condition);
    });

    test('should update trigger property name', () {
      final updatedTrigger = trigger.copyWith(propertyName: 'newProperty');

      expect(updatedTrigger.propertyName, 'newProperty');
      expect(updatedTrigger.modelId, trigger.modelId);
      expect(updatedTrigger.condition, trigger.condition);
      expect(updatedTrigger.value, trigger.value);
    });

    test('should describe the trigger', () {
      final description = trigger.toDescription([smartModel]);

      expect(
          description,
          'When "${smartModel.name}" ${trigger.propertyName} '
          '${trigger.condition.name} ${trigger.value}');
    });
  });

  group('Action', () {
    test('should convert action to JSON and back', () {
      final json = action.toJson();
      final newAction = Action.fromJson(json);

      expect(newAction.modelId, action.modelId);
      expect(newAction.propertyName, action.propertyName);
      expect(newAction.value, 1);
    });

    test('should update action value', () {
      final updatedAction = action.copyWith(value: 2);

      expect(updatedAction.value, 2);
      expect(updatedAction.modelId, action.modelId);
      expect(updatedAction.propertyName, action.propertyName);
    });

    test('should update action property name', () {
      final updatedAction = action.copyWith(propertyName: 'newProperty');

      expect(updatedAction.propertyName, 'newProperty');
      expect(updatedAction.modelId, action.modelId);
      expect(updatedAction.value, action.value);
    });

    test('should describe the action', () {
      final description = action.toDescription([smartModel]);

      expect(
          description,
          'Set "${smartModel.name}" ${action.propertyName} '
          'to ${action.value}');
    });
  });
}

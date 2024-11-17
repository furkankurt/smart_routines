import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:smart_routines/app/data/models/condition.dart';
import 'package:smart_routines/app/data/models/property/property.dart';
import 'package:smart_routines/app/data/models/routine/routine.dart';
import 'package:smart_routines/app/data/models/smart_model/smart_model.dart';
import 'package:smart_routines/core/extensions/string_extension.dart';

class TriggerSettingsWidget extends StatelessWidget {
  const TriggerSettingsWidget({
    required this.smartModels,
    this.trigger,
    super.key,
  });

  final Trigger? trigger;
  final List<SmartModel> smartModels;

  Future<Trigger?> show(BuildContext context) {
    return showModalBottomSheet<Trigger>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      useSafeArea: true,
      builder: build,
    );
  }

  SmartModel? getSmartModel(String? modelId) {
    return smartModels.firstWhereOrNull((e) => e.id == modelId);
  }

  Property? getProperty(String? modelId, String? propertyName) {
    return getSmartModel(modelId)?.properties.firstWhereOrNull(
          (e) => e.name == propertyName,
        );
  }

  FormGroup get formGroup => fb.group({
        'smartModel': FormControl(
          value: getSmartModel(trigger?.modelId),
          validators: [Validators.required],
        ),
        'property': FormControl(
          value: getProperty(trigger?.modelId, trigger?.propertyName),
          validators: [Validators.required],
        ),
        'condition': FormControl(
          value: trigger?.condition,
          validators: [Validators.required],
        ),
        'value': FormControl<String>(
          value: jsonEncode(trigger?.value),
          validators: [Validators.required],
        ),
      });

  Future<void> save(BuildContext context, FormGroup form) async {
    form.markAllAsTouched();
    if (form.valid) {
      final model = form.control('smartModel').value as SmartModel;
      final property = form.control('property').value as Property;
      final condition = form.control('condition').value as Condition;
      final value = form.control('value').value;
      final updatedTrigger = trigger?.copyWith(
            modelId: model.id,
            propertyName: property.name,
            condition: condition,
            value: (value as String).toValue(),
          ) ??
          Trigger(
            modelId: model.id,
            propertyName: property.name,
            condition: condition,
            value: (value as String).toValue(),
          );
      Navigator.of(context).pop(updatedTrigger);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.viewInsetsOf(context).copyWith(left: 16, right: 16),
      child: ListView(
        shrinkWrap: true,
        primary: false,
        children: [
          const _HeaderWidget(),
          const SizedBox(height: 16),
          ReactiveFormBuilder(
            form: () => formGroup,
            builder: (context, form, child) {
              return ReactiveFormConsumer(
                builder: (context, form, child) {
                  final model = form.control('smartModel').value as SmartModel?;
                  final property = form.control('property').value as Property?;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SmartModelWidget(
                        form: form,
                        smartModels: smartModels,
                      ),
                      const SizedBox(height: 16),
                      if (model != null)
                        _PropertyWidget(
                          form: form,
                          model: model,
                        ),
                      const SizedBox(height: 16),
                      if (property != null) ...[
                        _ConditionWidget(
                          property: property,
                        ),
                        const SizedBox(height: 16),
                        _ValueField(property: property),
                      ],
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            minimumSize: const Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () async => save(context, form),
                          child: const Text('Save Trigger'),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Trigger Settings',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const Divider(),
        const Text('You can edit the trigger settings below'),
      ],
    );
  }
}

class _SmartModelWidget extends StatelessWidget {
  const _SmartModelWidget({
    required this.form,
    required this.smartModels,
  });
  final FormGroup form;
  final List<SmartModel> smartModels;

  @override
  Widget build(BuildContext context) {
    return ReactiveDropdownField(
      formControlName: 'smartModel',
      decoration: const InputDecoration(
        labelText: 'Smart Model',
        helperText: 'Choose the smart model that triggers this routine',
      ),
      items: smartModels
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e.name),
            ),
          )
          .toList(),
      onChanged: (control) {
        form.control('property').value = null;
        form.control('condition').value = null;
        form.control('value').value = null;
      },
    );
  }
}

class _PropertyWidget extends StatelessWidget {
  const _PropertyWidget({
    required this.form,
    required this.model,
  });
  final FormGroup form;
  final SmartModel model;

  @override
  Widget build(BuildContext context) {
    return ReactiveDropdownField(
      formControlName: 'property',
      decoration: const InputDecoration(
        labelText: 'Property',
        helperText: 'Choose the property that triggers this routine',
      ),
      items: model.properties
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e.name.toTitleCase),
            ),
          )
          .toList(),
      onChanged: (control) {
        form.control('condition').value = null;
        form.control('value').value = null;
      },
    );
  }
}

class _ConditionWidget extends StatelessWidget {
  const _ConditionWidget({
    required this.property,
  });

  final Property property;

  @override
  Widget build(BuildContext context) {
    return ReactiveDropdownField(
      formControlName: 'condition',
      decoration: const InputDecoration(
        labelText: 'Condition',
        helperText: 'Choose the condition that triggers this routine',
      ),
      items: Condition.values
          .where(
            property.supportedConditions.contains,
          )
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e.name.toTitleCase),
            ),
          )
          .toList(),
    );
  }
}

class _ValueField extends StatelessWidget {
  const _ValueField({
    required this.property,
  });
  final Property property;

  @override
  Widget build(BuildContext context) {
    return ReactiveFormField<String, dynamic>(
      formControlName: 'value',
      builder: (field) {
        final type = field.value != null
            ? (field.value as String).toValue().runtimeType
            : property.value.runtimeType;
        if (type == bool) {
          field.didChange(field.value == 'true' ? 'true' : 'false');
        }
        return switch (type) {
          num || int || double => ReactiveTextField(
              formControl: field.control,
              decoration: InputDecoration(
                labelText: property.name.toTitleCase,
                helperText: property.description,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
            ),
          String => ReactiveTextField(
              formControl: field.control,
              decoration: InputDecoration(
                labelText: property.name.toTitleCase,
                helperText: property.description,
              ),
              keyboardType: TextInputType.text,
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
            ),
          bool => SwitchListTile(
              onChanged: (v) => field.didChange(v ? 'true' : 'false'),
              value: field.value == 'true',
              title: Text(property.name.toTitleCase),
              subtitle: property.description != null
                  ? Text(
                      property.description!,
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  : null,
              contentPadding: EdgeInsets.zero,
            ),
          _ => const SizedBox(),
        };
      },
    );
  }
}

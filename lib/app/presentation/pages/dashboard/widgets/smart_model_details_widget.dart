import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:smart_routines/app/data/models/property/property.dart';
import 'package:smart_routines/app/data/models/smart_model/smart_model.dart';
import 'package:smart_routines/core/extensions/string_extension.dart';

class SmartModelDetails extends StatelessWidget {
  const SmartModelDetails({
    required this.model,
    super.key,
  });

  final SmartModel model;

  Future<SmartModel?> show(BuildContext context) {
    return showModalBottomSheet<SmartModel>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      useSafeArea: true,
      builder: build,
    );
  }

  FormGroup get formGroup => fb.group({
        'isActive': FormControl<bool>(value: model.isActive),
        ...Map.fromEntries(
          model.properties.map((e) => MapEntry(e.name, [e.value])),
        ),
      });

  void save(BuildContext context, FormGroup form) {
    if (form.valid) {
      final updatedModel = model.copyWith(
        isActive: form.control('isActive').value as bool?,
        properties: model.properties.map((e) {
          final value = form.control(e.name).value;
          return e.copyWith(value: value);
        }).toList(),
      );
      Navigator.of(context).pop(updatedModel);
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
          _HeaderWidget(model: model),
          const SizedBox(height: 16),
          ReactiveFormBuilder(
            form: () => formGroup,
            builder: (context, form, child) {
              return Column(
                children: [
                  const _StateWidget(),
                  const SizedBox(height: 16),
                  ...List.generate(model.properties.length, (index) {
                    final property = model.properties[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _PropertyWidget(property: property),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => save(context, form),
                      child: const Text('Update Model'),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({
    required this.model,
  });

  final SmartModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              model.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Spacer(),
            _LastUpdateWidget(model.lastUpdated),
          ],
        ),
        const Divider(),
        const Text('You can edit the properties of this device below'),
      ],
    );
  }
}

class _LastUpdateWidget extends StatelessWidget {
  const _LastUpdateWidget(this.lastUpdated);

  final DateTime? lastUpdated;

  @override
  Widget build(BuildContext context) {
    if (lastUpdated == null) return const SizedBox();
    return Row(
      children: [
        const Icon(Icons.access_time, size: 16),
        const SizedBox(width: 4),
        Text(
          DateFormat('dd MMM, HH:mm').format(lastUpdated ?? DateTime.now()),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _PropertyWidget extends StatelessWidget {
  const _PropertyWidget({required this.property});
  final Property property;

  @override
  Widget build(BuildContext context) {
    return switch (property.value.runtimeType) {
      num || int || double => ReactiveTextField<num>(
          formControlName: property.name,
          decoration: InputDecoration(
            labelText: property.name.toTitleCase,
            helperText: property.description,
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
        ),
      String => ReactiveTextField(
          formControlName: property.name,
          decoration: InputDecoration(
            labelText: property.name.toTitleCase,
            helperText: property.description,
          ),
          keyboardType: TextInputType.text,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
        ),
      bool => ReactiveSwitchListTile(
          formControlName: property.name,
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
  }
}

class _StateWidget extends StatelessWidget {
  const _StateWidget();

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, form, child) => ReactiveSwitchListTile(
        formControlName: 'isActive',
        title: const Text('Device state'),
        subtitle: Text(
          form.control('isActive').value == true ? 'Active' : 'Inactive',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}

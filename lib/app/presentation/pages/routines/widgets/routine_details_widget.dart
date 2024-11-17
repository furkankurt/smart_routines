import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:reactive_forms/reactive_forms.dart';
import 'package:smart_routines/app/data/models/routine/routine.dart';
import 'package:smart_routines/app/data/models/smart_model/smart_model.dart';
import 'package:smart_routines/app/presentation/pages/routines/widgets/action_settings_widget.dart';
import 'package:smart_routines/app/presentation/pages/routines/widgets/trigger_settings_widget.dart';

class RoutineDetailsWidget extends StatelessWidget {
  const RoutineDetailsWidget({
    required this.smartModels,
    this.routine,
    this.onDeleted,
    super.key,
  });

  final Routine? routine;
  final List<SmartModel> smartModels;
  final VoidCallback? onDeleted;

  Future<Routine?> show(BuildContext context) {
    return showModalBottomSheet<Routine>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      useSafeArea: true,
      builder: build,
    );
  }

  FormGroup get formGroup => fb.group(
        {
          'name': FormControl<String>(
            value: routine?.name,
            validators: [Validators.required],
          ),
          'isActive': FormControl<bool>(
            value: routine?.isActive,
            validators: [Validators.required],
          ),
          'trigger': FormControl<Trigger>(
            value: routine?.trigger,
            validators: [Validators.required],
          ),
          'actions': FormArray<Action>(
            routine?.actions
                    .map(
                      (a) => FormControl<Action>(
                        value: a,
                        validators: [Validators.required],
                      ),
                    )
                    .toList() ??
                <FormControl<Action>>[],
            validators: [Validators.required],
          ),
        },
      );

  Future<void> save(BuildContext context, FormGroup form) async {
    if (form.valid) {
      final actions = form.control('actions').value as List<Action?>;
      final updatedModel = routine?.copyWith(
            name: form.control('name').value as String?,
            isActive: form.control('isActive').value as bool?,
            trigger: form.control('trigger').value as Trigger?,
            actions: [...actions.whereNotNull()],
          ) ??
          Routine(
            name: form.control('name').value as String,
            isActive: form.control('isActive').value as bool,
            trigger: form.control('trigger').value as Trigger,
            actions: [...actions.whereNotNull()],
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
          _Header(routine: routine, onDeleted: onDeleted),
          const SizedBox(height: 16),
          ReactiveFormBuilder(
            form: () => formGroup,
            builder: (context, form, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _NameWidget(),
                  const SizedBox(height: 16),
                  const _StateWidget(),
                  const SizedBox(height: 16),
                  const Divider(),
                  _TriggerWidget(smartModels: smartModels),
                  const SizedBox(height: 16),
                  const Divider(),
                  _ActionsWidget(smartModels: smartModels),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: FilledButton(
                      key: const Key('save_routine_button'),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async => save(context, form),
                      child: const Text('Save'),
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

class _Header extends StatelessWidget {
  const _Header({
    required this.routine,
    required this.onDeleted,
  });

  final Routine? routine;
  final VoidCallback? onDeleted;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              routine?.name != null
                  ? '${routine?.name} Routine'
                  : 'Add Routine',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Spacer(),
            if (routine != null)
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  onDeleted?.call();
                  Navigator.of(context).pop();
                },
              ),
          ],
        ),
        const Divider(),
        const Text('You can edit the properties of this routine below'),
      ],
    );
  }
}

class _NameWidget extends StatelessWidget {
  const _NameWidget();

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: 'name',
      decoration: const InputDecoration(
        label: Text('Routine Name'),
      ),
      keyboardType: TextInputType.text,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
    );
  }
}

class _TriggerWidget extends StatelessWidget {
  const _TriggerWidget({
    required this.smartModels,
  });

  final List<SmartModel> smartModels;

  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: false,
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text.rich(
            TextSpan(
              text: 'Trigger',
              children: [
                TextSpan(
                  text: '\nRoutine will be triggered when this event occurs',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        ReactiveFormConsumer(
          builder: (context, form, child) {
            final trigger = form.control('trigger').value as Trigger?;
            return OutlinedButton(
              onPressed: () async {
                final updatedTrigger = await TriggerSettingsWidget(
                  smartModels: smartModels,
                  trigger: trigger,
                ).show(context);
                if (updatedTrigger != null) {
                  form.control('trigger').updateValue(updatedTrigger);
                }
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8),
              ),
              child: Text(
                trigger?.toDescription(smartModels) ??
                    'Click here to set trigger',
                textAlign: TextAlign.center,
              ),
            );
          },
        ),
      ],
    );
  }
}

class _ActionsWidget extends StatelessWidget {
  const _ActionsWidget({
    required this.smartModels,
  });

  final List<SmartModel> smartModels;

  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: false,
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'Actions',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        ReactiveFormConsumer(
          builder: (context, form, child) {
            final actions = form.control('actions') as FormArray<Action?>;
            return ListView(
              primary: false,
              shrinkWrap: true,
              children: [
                ...actions.controls.mapIndexed(
                  (index, action) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: Text(
                        '${index + 1}: '
                        '${action.value.toDescription(smartModels)}',
                      ),
                      onTap: () async {
                        final updatedAction = await ActionSettingsWidget(
                          smartModels: smartModels,
                          action: action.value,
                        ).show(context);
                        if (updatedAction != null) {
                          actions.controls[index].updateValue(updatedAction);
                        }
                      },
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          actions.removeAt(index);
                        },
                      ),
                    );
                  },
                ),
                OutlinedButton.icon(
                  onPressed: () async {
                    final newAction = await ActionSettingsWidget(
                      smartModels: smartModels,
                    ).show(context);
                    if (newAction != null) {
                      actions.add(FormControl<Action>(value: newAction));
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Action'),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _StateWidget extends StatelessWidget {
  const _StateWidget();

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, form, child) => ReactiveSwitchListTile(
        formControlName: 'isActive',
        title: const Text('Routine state'),
        subtitle: Text(
          form.control('isActive').value == true ? 'Active' : 'Inactive',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}

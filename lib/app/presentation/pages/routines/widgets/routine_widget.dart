import 'package:flutter/material.dart';
import 'package:smart_routines/app/data/models/routine/routine.dart';
import 'package:smart_routines/app/presentation/widgets/model_icon.dart';
import 'package:smart_routines/app/presentation/widgets/state_icon.dart';

typedef OnTap = void Function();
typedef ToggleState = void Function();

class RoutineWidget extends StatelessWidget {
  const RoutineWidget({
    required this.routine,
    this.onTap,
    this.toggleState,
    super.key,
  });

  final Routine routine;
  final OnTap? onTap;
  final ToggleState? toggleState;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0,
      shadowColor: Theme.of(context).colorScheme.shadow.withOpacity(0.4),
      child: InkWell(
        onTap: onTap,
        overlayColor: WidgetStatePropertyAll(
          Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4),
        ),
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const ModelIcon(icon: Icons.switch_access_shortcut),
                  const Spacer(),
                  StateIcon(state: routine.isActive),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                routine.name,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              _ToggleWidget(routine, toggleState: toggleState),
            ],
          ),
        ),
      ),
    );
  }
}

class _ToggleWidget extends StatelessWidget {
  const _ToggleWidget(
    this.routine, {
    this.toggleState,
  });

  final Routine routine;
  final ToggleState? toggleState;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.only(left: 4),
      dense: true,
      value: routine.isActive,
      onChanged: (value) => toggleState?.call(),
      title: Text(
        routine.isActive ? 'Active' : 'Inactive',
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}

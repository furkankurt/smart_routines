import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:smart_routines/app/data/models/property/property.dart';
import 'package:smart_routines/app/data/models/smart_model/smart_model.dart';
import 'package:smart_routines/app/presentation/widgets/model_icon.dart';
import 'package:smart_routines/app/presentation/widgets/state_icon.dart';
import 'package:smart_routines/core/extensions/string_extension.dart';

typedef OnTap = void Function();
typedef OnPropertyChange = void Function(String name, dynamic value);

class SmartModelWidget extends StatelessWidget {
  const SmartModelWidget({
    required this.smartModel,
    this.onTap,
    this.onPropertyChange,
    super.key,
  });

  final SmartModel smartModel;
  final OnTap? onTap;
  final OnPropertyChange? onPropertyChange;

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
                  if (smartModel.type == ModelType.device)
                    const ModelIcon(icon: Icons.now_widgets_outlined)
                  else
                    const ModelIcon(icon: Icons.satellite_outlined),
                  const Spacer(),
                  StateIcon(
                    state: smartModel.isActive,
                    activeIcon: Icons.wifi,
                    inactiveIcon: Icons.wifi_off_outlined,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                smartModel.name,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              ...smartModel.properties
                  .where(
                (element) => element.name != 'power' && element.name != 'alarm',
              )
                  .map((property) {
                return Text.rich(
                  TextSpan(
                    text: '${property.name.toTitleCase}: ',
                    style: Theme.of(context).textTheme.bodySmall,
                    children: [
                      TextSpan(
                        text: property.value.toString(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                );
              }),
              const Spacer(),
              _ToggleWidget(smartModel, onPropertyChange: onPropertyChange),
            ],
          ),
        ),
      ),
    );
  }
}

class _ToggleWidget extends StatelessWidget {
  const _ToggleWidget(
    this.smartModel, {
    this.onPropertyChange,
  });

  final SmartModel smartModel;
  final OnPropertyChange? onPropertyChange;

  List<String> get _supportedPropertyNames => [
        'power',
        'alarm',
      ];

  Property? get supportedProperty => smartModel.properties.firstWhereOrNull(
        (element) =>
            _supportedPropertyNames.contains(element.name) &&
            element.value is bool,
      );

  @override
  Widget build(BuildContext context) {
    if (supportedProperty == null) return const SizedBox();
    return IgnorePointer(
      ignoring: smartModel.isActive == false,
      child: SwitchListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.only(left: 4),
        dense: true,
        value: supportedProperty!.value == true,
        onChanged: (value) =>
            onPropertyChange?.call(supportedProperty!.name, value),
        title: Text(
          supportedProperty!.value == true ? 'On' : 'Off',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}

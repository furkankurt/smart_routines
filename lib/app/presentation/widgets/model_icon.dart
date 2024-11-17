import 'package:flutter/material.dart';

class ModelIcon extends StatelessWidget {
  const ModelIcon({required this.icon, super.key});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

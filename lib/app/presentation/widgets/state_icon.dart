import 'package:flutter/material.dart';

class StateIcon extends StatelessWidget {
  const StateIcon({
    required this.state,
    this.activeIcon = Icons.check,
    this.inactiveIcon = Icons.close,
    super.key,
  });

  final bool state;
  final IconData activeIcon;
  final IconData inactiveIcon;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: state
              ? Colors.green.withOpacity(0.1)
              : Colors.red.withOpacity(0.1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(
            state ? activeIcon : inactiveIcon,
            color: state ? Colors.green : Colors.red,
            size: 14,
          ),
        ),
      ),
    );
  }
}

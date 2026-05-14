import 'package:flutter/material.dart';
import 'package:spendly/themes/app_spacing.dart';

class CircleWithIcon extends StatelessWidget {
  final IconData icon;

  const CircleWithIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        ),
      child: Icon(icon, size: 35),
    );
  }
}

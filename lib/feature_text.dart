import 'package:flutter/material.dart';

class FeatureIconText extends StatelessWidget {

  const FeatureIconText({
    required this.icon, required this.label, super.key,
  });
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}
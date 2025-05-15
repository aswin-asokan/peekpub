import 'package:flutter/material.dart';
import 'package:trelza_pubseek/shared/extensions/app_theme_extensions.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.spacing = 0,
  });
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  final double spacing;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: context.colorScheme.secondary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 10,
            spreadRadius: 0,
            color: Colors.black.withAlpha(30),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        spacing: spacing,
        children: children,
      ),
    );
  }
}

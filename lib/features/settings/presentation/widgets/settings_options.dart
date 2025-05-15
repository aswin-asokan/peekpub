import 'package:flutter/material.dart';
import 'package:trelza_peekpub/shared/extensions/app_theme_extensions.dart';

class SettingsOptions extends StatelessWidget {
  const SettingsOptions({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        spacing: 15,
        children: [
          Icon(icon, size: 25, color: context.colorScheme.onTertiary),
          Text(title, style: context.textTheme.titleSmall),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: context.colorScheme.onTertiary,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:trelza_peekpub/shared/extensions/app_theme_extensions.dart';

class LinkButton extends StatelessWidget {
  const LinkButton({
    super.key,
    required this.onPress,
    required this.color,
    required this.title,
  });
  final Color color;
  final String title;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(color),
        elevation: WidgetStatePropertyAll(0),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      child: Text(
        title,
        style: context.textTheme.labelMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}

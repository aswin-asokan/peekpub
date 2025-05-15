import 'package:flutter/material.dart';
import 'package:trelza_peekpub/shared/widgets/custom_container.dart';
import 'package:trelza_peekpub/shared/extensions/app_theme_extensions.dart';

class ListCard extends StatelessWidget {
  const ListCard({
    super.key,
    required this.name,
    required this.description,
    required this.version,
    required this.onPress,
  });
  final String name;
  final String description;
  final String version;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: CustomContainer(
          spacing: 10,
          children: [
            Text(name, style: context.textTheme.titleMedium),
            Text(description, style: context.textTheme.bodySmall),
            FittedBox(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 10,
                ),

                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text("v$version", style: context.textTheme.labelSmall),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

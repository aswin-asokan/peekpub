import 'package:flutter/material.dart';
import 'package:trelza_peekpub/shared/extensions/app_theme_extensions.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({
    super.key,
    required this.error,
    required this.onPress,
    this.label = "retry",
  });
  final VoidCallback onPress;
  final String error;
  final String? label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: context.colorScheme.primary,
            size: 48,
          ),
          const SizedBox(height: 10),
          Text(
            error,
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPress,
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  context.colorScheme.primary,
                ),
              ),
              child: Text('Retry', style: context.textTheme.labelSmall),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchNotFound extends StatelessWidget {
  const SearchNotFound({super.key, required this.query});
  final String query;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.search_off, color: Colors.grey, size: 48),
              const SizedBox(height: 10),
              Text(
                'No packages found for "$query"',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

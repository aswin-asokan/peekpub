import 'package:flutter/material.dart';
import 'package:trelza_peekpub/shared/extensions/app_theme_extensions.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircularProgressIndicator(color: context.colorScheme.primary),
      ),
    );
  }
}

class ListEnd extends StatelessWidget {
  const ListEnd({super.key, required this.query});
  final String query;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          query.isNotEmpty
              ? "End of search results"
              : "You've reached the end!",
          style: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}

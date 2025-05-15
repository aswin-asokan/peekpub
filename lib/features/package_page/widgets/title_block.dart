import 'package:flutter/material.dart';
import 'package:trelza_pubseek/shared/widgets/custom_container.dart';
import 'package:trelza_pubseek/features/package_page/widgets/link_button.dart';
import 'package:trelza_pubseek/shared/extensions/app_theme_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

class TitleBlock extends StatelessWidget {
  const TitleBlock({
    super.key,
    required this.title,
    required this.version,
    required this.pubdevLink,
    required this.documentationLink,
    required this.githubLink,
    this.isDiscontinued = false,
  });
  final String title;
  final String version;
  final String pubdevLink;
  final String documentationLink;
  final String githubLink;
  final bool isDiscontinued;
  void _launch(String urlString) async {
    final url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw Exception('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      children: [
        Text(title, style: context.textTheme.bodyLarge),
        SizedBox(height: 5),
        Row(
          spacing: 10,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              width: 80,
              decoration: BoxDecoration(
                color: context.colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text("v$version", style: context.textTheme.labelSmall),
              ),
            ),
            if (isDiscontinued)
              Container(
                padding: const EdgeInsets.all(4),
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    context.loc.discontinued,
                    style: context.textTheme.labelSmall,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: LinkButton(
                onPress: () {
                  _launch(pubdevLink);
                },
                color: context.colorScheme.primary,
                title: "Pub.dev",
              ),
            ),
            const SizedBox(width: 10), // spacing between buttons
            Expanded(
              child: LinkButton(
                onPress: () {
                  _launch(documentationLink);
                },
                color: context.colorScheme.tertiary,
                title: "Docs",
              ),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: LinkButton(
            onPress: () {
              print("Git: $githubLink");
              if (githubLink != context.loc.notavailable) {
                _launch(githubLink);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: context.colorScheme.primary,
                    content: Text(
                      context.loc.noGit,
                      style: context.textTheme.bodySmall,
                    ),
                  ),
                );
              }
              _launch(githubLink);
            },
            color: context.colorScheme.surface,
            title: "GitHub",
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:trelza_pubseek/shared/extensions/app_theme_extensions.dart';

class VersionInfo extends StatelessWidget {
  const VersionInfo({super.key, required this.title, required this.info});
  final String title;
  final String info;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.textTheme.bodyMedium),
        Text(info, style: context.textTheme.bodySmall),
      ],
    );
  }
}

class VersionDate extends StatelessWidget {
  const VersionDate({super.key, required this.date, required this.sdkVersion});
  final String date;
  final String sdkVersion;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: VersionInfo(title: context.loc.published, info: date),
          ),
          VerticalDivider(
            color: context.colorScheme.surfaceTint,
            thickness: 1,
            width: 15,
          ),
          SizedBox(width: 8),
          Expanded(
            child: VersionInfo(
              title: "SDK ${context.loc.version}",
              info: sdkVersion,
            ),
          ),
        ],
      ),
    );
  }
}

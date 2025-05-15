import 'package:flutter/material.dart';
import 'package:trelza_pubseek/features/settings/presentation/screens/lang_page.dart';
import 'package:trelza_pubseek/features/settings/presentation/screens/about.dart';
import 'package:trelza_pubseek/features/settings/presentation/widgets/settings_options.dart';
import 'package:trelza_pubseek/shared/extensions/app_theme_extensions.dart';
import 'package:trelza_pubseek/shared/widgets/custom_container.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.settings, style: context.textTheme.titleLarge),
        centerTitle: true,
        backgroundColor: context.colorScheme.surface,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            spacing: 20,
            children: [
              CustomContainer(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Trelza PeekPub",
                              style: context.textTheme.bodyLarge,
                            ),
                            Text(
                              context.loc.info,
                              style: context.textTheme.bodySmall,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Image.asset("assets/logo/logo.png", height: 100),
                    ],
                  ),
                ],
              ),
              CustomContainer(
                spacing: 25,
                children: [
                  SettingsOptions(
                    icon: Icons.language,
                    title: context.loc.language,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LangPage()),
                      );
                    },
                  ),
                  SettingsOptions(
                    icon: Icons.info_outline,
                    title: context.loc.about,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => About()),
                      );
                    },
                  ),
                ],
              ),
              CustomContainer(
                spacing: 25,
                children: [
                  SettingsOptions(
                    icon: Icons.share,
                    title: context.loc.share,
                    onTap: () {
                      SharePlus.instance.share(
                        ShareParams(
                          text:
                              '${context.loc.shareInfo} \nhttps://example.com',
                        ),
                      );
                    },
                  ),
                  SettingsOptions(
                    icon: Icons.apps,
                    title: context.loc.more,
                    onTap: () {},
                  ),
                  SettingsOptions(
                    icon: Icons.coffee_rounded,
                    title: context.loc.coffee,
                    onTap: () {
                      _launch("https://buymeacoffee.com/aswin_asokan");
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _launch(String urlString) async {
  final url = Uri.parse(urlString);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw Exception('Could not launch $urlString');
  }
}

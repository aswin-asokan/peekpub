import 'package:flutter/material.dart';
import 'package:trelza_peekpub/shared/extensions/app_theme_extensions.dart';
import 'package:trelza_peekpub/shared/widgets/custom_container.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({super.key});
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
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.about, style: context.textTheme.titleLarge),
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
                          spacing: 10,
                          children: [
                            Text(
                              "Trelza PeekPub",
                              style: context.textTheme.bodyLarge,
                            ),
                            Text(
                              "${context.loc.version}: 1.0.0\n${context.loc.published}: 15 May, 2025",
                              style: context.textTheme.bodySmall,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                      Image.asset("assets/logo/logo.png", height: 90),
                    ],
                  ),
                ],
              ),
              CustomContainer(
                spacing: 10,
                children: [
                  Text(
                    context.loc.description,
                    style: context.textTheme.titleMedium,
                  ),
                  Text(
                    context.loc.fullInfo,
                    style: context.textTheme.bodySmall,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
              CustomContainer(
                spacing: 10,
                children: [
                  Text(
                    context.loc.newFeatures,
                    style: context.textTheme.titleMedium,
                  ),
                  Text(
                    "• ${context.loc.favPack}\n• ${context.loc.showNewVer}",
                    style: context.textTheme.bodySmall,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      context.colorScheme.primary,
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    _launch("https://github.com/aswin-asokan/peekpub");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/github.svg",
                        height: 20,
                        colorFilter: ColorFilter.mode(
                          context.colorScheme.onPrimary,
                          BlendMode.srcIn,
                        ),
                      ),
                      Text("Github Page", style: context.textTheme.labelMedium),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

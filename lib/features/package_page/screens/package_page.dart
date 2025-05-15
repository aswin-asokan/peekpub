import 'package:flutter/material.dart';
import 'package:trelza_pubseek/features/home/presentation/widgets/error_card.dart';
import 'package:trelza_pubseek/features/home/presentation/widgets/loading.dart';
import 'package:trelza_pubseek/features/package_page/services/info_service.dart';
import 'package:trelza_pubseek/features/package_page/widgets/platforms.dart';
import 'package:trelza_pubseek/features/package_page/widgets/version_info.dart';
import 'package:trelza_pubseek/shared/widgets/custom_container.dart';
import 'package:trelza_pubseek/features/package_page/widgets/title_block.dart';
import 'package:trelza_pubseek/shared/extensions/app_theme_extensions.dart';
import 'package:intl/intl.dart';

class PackagePage extends StatefulWidget {
  const PackagePage({
    super.key,
    required this.packageName,
    required this.packageVersion,
    required this.packageDescription,
  });
  final String packageName;
  final String packageVersion;
  final String packageDescription;
  @override
  State<PackagePage> createState() => _PackagePageState();
}

class _PackagePageState extends State<PackagePage> {
  String pubdevLink = "";
  String documentationLink = "";
  String? githubLink;
  String publishedDate = "";
  String? sdkVersion;
  String? flutterVersion;
  List<String> platforms = [];

  bool isLoading = true;
  bool hasError = false;

  void getPackageDetails(String packageName) async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    final service = PubDevService();
    final info = await service.fetchPackageInfo(packageName);

    if (info != null) {
      setState(() {
        pubdevLink = info.pubDevLink;
        documentationLink = info.documentationLink;
        githubLink = info.githubLink;
        try {
          final dateTime = DateTime.parse(info.publishedDate);
          publishedDate = DateFormat("MMM dd, yyyy").format(dateTime);
        } catch (e) {
          publishedDate = info.publishedDate;
        }

        sdkVersion = info.sdkVersion;
        flutterVersion = info.flutterVersion;
        platforms = info.platforms;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPackageDetails(widget.packageName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorScheme.surface,
        title: Text(context.loc.packagePageTitle),
      ),
      body:
          isLoading
              ? Center(child: Loading())
              : hasError
              ? Center(
                child: ErrorCard(
                  error: context.loc.error,
                  onPress: () {
                    Navigator.pop(context);
                  },
                  label: context.loc.goBack,
                ),
              )
              : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    spacing: 20,
                    children: [
                      TitleBlock(
                        title: widget.packageName,
                        version: widget.packageVersion,
                        pubdevLink: pubdevLink,
                        documentationLink: documentationLink,
                        githubLink: githubLink ?? context.loc.notavailable,
                        isDiscontinued:
                            widget.packageDescription == "Discontinued",
                      ),
                      CustomContainer(
                        children: [
                          VersionDate(
                            date: publishedDate,
                            sdkVersion: sdkVersion ?? context.loc.notavailable,
                          ),
                          Divider(
                            color: context.colorScheme.surfaceTint,
                            thickness: 1,
                          ),
                          VersionInfo(
                            title: "Flutter ${context.loc.version}",
                            info: flutterVersion ?? context.loc.notavailable,
                          ),
                        ],
                      ),
                      CustomContainer(
                        spacing: 10,
                        children: [
                          Text(
                            context.loc.platforms,
                            style: context.textTheme.bodyMedium,
                          ),
                          platforms.isNotEmpty
                              ? Row(
                                spacing: 5,
                                children:
                                    [
                                          Platforms(
                                            platform: PlatformType.windows,
                                          ),
                                          Platforms(
                                            platform: PlatformType.android,
                                          ),
                                          Platforms(platform: PlatformType.ios),
                                          Platforms(platform: PlatformType.web),
                                          Platforms(
                                            platform: PlatformType.macos,
                                          ),
                                          Platforms(
                                            platform: PlatformType.linux,
                                          ),
                                        ]
                                        .where(
                                          (p) => platforms.contains(
                                            p.platform.name,
                                          ),
                                        )
                                        .toList(),
                              )
                              : Text(
                                context.loc.notavailable,
                                style: context.textTheme.bodySmall,
                              ),
                        ],
                      ),
                      CustomContainer(
                        children: [
                          Text(
                            context.loc.description,
                            style: context.textTheme.bodyMedium,
                          ),
                          Text(
                            widget.packageDescription,
                            style: context.textTheme.bodySmall,
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

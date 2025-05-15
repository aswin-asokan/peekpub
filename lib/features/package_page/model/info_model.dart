class PackageInfoModel {
  final String pubDevLink;
  final String documentationLink;
  final String? githubLink;
  final String publishedDate;
  final String? sdkVersion;
  final String? flutterVersion;
  final List<String> platforms;

  PackageInfoModel({
    required this.pubDevLink,
    required this.documentationLink,
    this.githubLink,
    required this.publishedDate,
    this.sdkVersion,
    this.flutterVersion,
    required this.platforms,
  });

  factory PackageInfoModel.fromJson(
    String packageName,
    Map<String, dynamic> json,
  ) {
    final latest = json['latest'];
    final pubspec = latest['pubspec'] ?? {};
    final environment = pubspec['environment'] ?? {};
    final pluginPlatforms = pubspec['flutter']?['plugin']?['platforms'];

    return PackageInfoModel(
      pubDevLink: 'https://pub.dev/packages/$packageName',
      documentationLink: 'https://pub.dev/documentation/$packageName/latest/',
      githubLink: pubspec['repository'],
      publishedDate: latest['published'] ?? '',
      sdkVersion: environment['sdk'],
      flutterVersion: environment['flutter'],
      platforms:
          pluginPlatforms != null
              ? pluginPlatforms.keys.cast<String>().toList()
              : [],
    );
  }
}

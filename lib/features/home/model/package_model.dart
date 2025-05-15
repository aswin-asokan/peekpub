class PackageInfo {
  final String name;
  final String latestVersion;
  final String? description;

  PackageInfo({
    required this.name,
    required this.latestVersion,
    this.description,
  });

  factory PackageInfo.fromJson(Map<String, dynamic> json) {
    String version = 'N/A';
    String? desc;
    if (json['latest'] != null && json['latest']['version'] != null) {
      version = json['latest']['version'];
    }
    if (json['latest'] != null &&
        json['latest']['pubspec'] != null &&
        json['latest']['pubspec']['description'] != null) {
      desc = json['latest']['pubspec']['description'];
    }
    return PackageInfo(
      name: json['name'] ?? 'Unknown Package',
      latestVersion: version,
      description: desc,
    );
  }

  factory PackageInfo.fromSearchApiJson(Map<String, dynamic> json) {
    String? descValue;
    if (json['description'] != null) {
      descValue = json['description'] as String?;
    } else if (json['latest'] != null &&
        json['latest']['pubspec'] != null &&
        json['latest']['pubspec']['description'] != null) {
      descValue = json['latest']['pubspec']['description'] as String?;
    }

    return PackageInfo(
      name: json['package'] ?? 'Unknown Package',
      latestVersion: json['version'] ?? 'N/A',
      description: descValue,
    );
  }
}

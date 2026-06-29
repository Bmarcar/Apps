class AppVersion {
  final String version;
  final String minVersion;
  final String apkUrl;
  final String? description;
  final bool forceUpdate;

  AppVersion({
    required this.version,
    required this.minVersion,
    required this.apkUrl,
    this.description,
    required this.forceUpdate,
  });

  factory AppVersion.fromMap(Map<String, dynamic> map) {
    return AppVersion(
      version: map['version'],
      minVersion: map['min_version'],
      apkUrl: map['apk_url'],
      description: map['description'],
      forceUpdate: map['force_update'] ?? false,
    );
  }
}

class AppVersionModel {
  final int statusCode;
  final bool isSuccess;
  final String message;
  final AppVersionData data;

  AppVersionModel({
    required this.statusCode,
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory AppVersionModel.fromJson(Map<String, dynamic> json) {
    return AppVersionModel(
      statusCode: json['statusCode'] ?? json['code'] ?? 0,
      isSuccess: json['isSuccess'] ?? false,
      message: json['message'] ?? '',
      data: AppVersionData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'isSuccess': isSuccess,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class AppVersionData {
  final PlatformVersionInfo? android;
  final PlatformVersionInfo? ios;

  AppVersionData({
    this.android,
    this.ios,
  });

  factory AppVersionData.fromJson(dynamic rawData) {
    // New API: data is a List of version entries, each has a `platformVersionId` or `platform` field
    if (rawData is List) {
      PlatformVersionInfo? androidInfo;
      PlatformVersionInfo? iosInfo;
      for (final item in rawData) {
        if (item is Map<String, dynamic>) {
          final platformId = item['platformVersionId'] ?? item['platformType'];
          final platformStr = (item['platform'] ?? '').toString().toLowerCase();
          if (platformId == 3 || platformStr == 'android') {
            androidInfo = PlatformVersionInfo.fromJson(item);
          } else if (platformId == 4 || platformStr == 'ios') {
            iosInfo = PlatformVersionInfo.fromJson(item);
          }
        }
      }
      return AppVersionData(android: androidInfo, ios: iosInfo);
    }
    // Legacy API: data was a Map with `android` and `ios` keys
    if (rawData is Map<String, dynamic>) {
      return AppVersionData(
        android: rawData['android'] != null ? PlatformVersionInfo.fromJson(rawData['android']) : null,
        ios: rawData['ios'] != null ? PlatformVersionInfo.fromJson(rawData['ios']) : null,
      );
    }
    // null or unexpected — return empty
    return AppVersionData();
  }

  Map<String, dynamic> toJson() {
    return {
      'android': android?.toJson(),
      'ios': ios?.toJson(),
    };
  }
}

class PlatformVersionInfo {
  final String minimumVersion;
  final String latestVersion;
  final bool forceUpdate;
  final String storeUrl;

  PlatformVersionInfo({
    required this.minimumVersion,
    required this.latestVersion,
    required this.forceUpdate,
    required this.storeUrl,
  });

  factory PlatformVersionInfo.fromJson(Map<String, dynamic> json) {
    return PlatformVersionInfo(
      minimumVersion: json['minimumVersion'] ?? json['minimum_version'] ?? '',
      latestVersion: json['latestVersion'] ?? json['latest_version'] ?? '',
      forceUpdate: json['forceUpdate'] ?? json['force_update'] ?? false,
      storeUrl: json['storeUrl'] ?? json['store_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'minimumVersion': minimumVersion,
      'latestVersion': latestVersion,
      'forceUpdate': forceUpdate,
      'storeUrl': storeUrl,
    };
  }
}

class SettingsModel {
  SettingsModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    SettingsData? parsedData;
    if (json['data'] != null) {
      if (json['data'] is List) {
        if ((json['data'] as List).isNotEmpty) {
          parsedData = SettingsData.fromJson(json['data'][0]);
        }
      } else if (json['data'] is Map<String, dynamic>) {
        parsedData = SettingsData.fromJson(json['data']);
      }
    }

    return SettingsModel(
      code: json['statusCode'] ?? json['code'] ?? -1,
      message: json['message'] ?? '',
      data: parsedData,
    );
  }

  final int code;
  final String message;
  final SettingsData? data;

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class SettingsData {
  SettingsData({
    required this.settingId,
    required this.whatsAppNumber,
    required this.instagramLink,
    required this.tikTokLink,
    required this.xLink,
    required this.faceBookLink,
    required this.youTubeLink,
    required this.arBasicInstructions,
    required this.enBasicInstructions,
    required this.snapChatLink,
    required this.countryId,
  });

  factory SettingsData.fromJson(Map<String, dynamic> json) {
    return SettingsData(
      settingId: json['settingId'] ?? 0,
      whatsAppNumber: json['whatsAppNumber'] ?? '',
      instagramLink: json['instagramLink'] ?? '',
      tikTokLink: json['tikTokLink'] ?? '',
      xLink: json['xLink'] ?? '',
      faceBookLink: json['faceBookLink'] ?? '',
      youTubeLink: json['youTubeLink'] ?? '',
      arBasicInstructions: json['arBasicInstructions'] ?? '',
      enBasicInstructions: json['enBasicInstructions'] ?? '',
      snapChatLink: json['snapChatLink'] ?? '',
      countryId: json['countryId'] ?? 0,
    );
  }

  final int settingId;
  final String whatsAppNumber;
  final String instagramLink;
  final String tikTokLink;
  final String xLink;
  final String faceBookLink;
  final String youTubeLink;
  final String arBasicInstructions;
  final String enBasicInstructions;
  final String snapChatLink;
  final int countryId;

  Map<String, dynamic> toJson() {
    return {
      'settingId': settingId,
      'whatsAppNumber': whatsAppNumber,
      'instagramLink': instagramLink,
      'tikTokLink': tikTokLink,
      'xLink': xLink,
      'faceBookLink': faceBookLink,
      'youTubeLink': youTubeLink,
      'arBasicInstructions': arBasicInstructions,
      'enBasicInstructions': enBasicInstructions,
      'snapChatLink': snapChatLink,
      'countryId': countryId,
    };
  }
}

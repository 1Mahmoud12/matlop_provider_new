class FireNotificationModel {
  FireNotificationModel({
    this.code,
    this.message,
    this.data,
  });

  FireNotificationModel.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  int? code;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    this.totalUnSeenCount,
    this.totalCount,
    this.data,
  });

  Data.fromJson(dynamic json) {
    totalUnSeenCount = json['totalUnSeenCount'];
    totalCount = json['totalCount'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ItemNotificationModel.fromJson(v));
      });
    }
  }

  int? totalUnSeenCount;
  int? totalCount;
  List<ItemNotificationModel>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalUnSeenCount'] = totalUnSeenCount;
    map['totalCount'] = totalCount;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ItemNotificationModel {
  ItemNotificationModel({
    this.notificationId,
    this.titleAr,
    this.titleEn,
    this.bodyAr,
    this.bodyEn,
    this.isSeen,
    this.module,
    this.entityId,
    this.creationTime,
  });

  ItemNotificationModel.fromJson(dynamic json) {
    notificationId = json['notificationId'];
    titleAr = json['titleAr'];
    titleEn = json['titleEn'];
    bodyAr = json['bodyAr'];
    bodyEn = json['bodyEn'];
    isSeen = json['isSeen'];
    module = json['module'];
    entityId = json['entityId'];
    creationTime = json['creationTime'];
  }

  int? notificationId;
  String? titleAr;
  String? titleEn;
  String? bodyAr;
  String? bodyEn;
  bool? isSeen;
  int? module;
  int? entityId;
  String? creationTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['notificationId'] = notificationId;
    map['titleAr'] = titleAr;
    map['titleEn'] = titleEn;
    map['bodyAr'] = bodyAr;
    map['bodyEn'] = bodyEn;
    map['isSeen'] = isSeen;
    map['module'] = module;
    map['entityId'] = entityId;
    map['creationTime'] = creationTime;
    return map;
  }
}

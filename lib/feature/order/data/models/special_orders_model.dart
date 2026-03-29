import 'package:matlop_provider/core/utils/constants.dart';

class SpecialOrdersModel {
  SpecialOrdersModel({
    this.code,
    this.message,
    this.data,
  });

  SpecialOrdersModel.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ItemSpecialOrder.fromJson(v));
      });
    }
  }

  num? code;
  dynamic message;
  List<ItemSpecialOrder>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ItemSpecialOrder {
  ItemSpecialOrder({
    this.specialOrderId,
    this.amount,
    this.clientId,
    this.notes,
    this.specialOrderEnum,
    this.specialOrderStatus,
    this.specialOrderStatusName,
    this.specialOrderName,
    this.media,
    this.specialOrderAssigment,
    this.isNew,
    this.offerAmount,
    this.submitted,
  });

  ItemSpecialOrder.fromJson(dynamic json) {
    specialOrderId = json['specialOrderId'];
    amount = json['amount'];
    clientId = json['clientId'];
    notes = json['notes'];
    specialOrderEnum = json['specialOrderEnum'];
    specialOrderStatus = json['specialOrderStatus'];
    specialOrderStatusName = json['specialOrderStatusName'];
    isNew = json['isNew'];
    submitted = json['submitted'];
    offerAmount = json['offerAmount'];
    specialOrderName = json['specialOrderName'];
    if (json['media'] != null) {
      media = [];
      json['media'].forEach((v) {
        media?.add(Media.fromJson(v));
      });
    }
    if (json['specialOrderAssigment'] != null) {
      specialOrderAssigment = [];
      json['specialOrderAssigment'].forEach((v) {
        specialOrderAssigment?.add(SpecialOrderAssigment.fromJson(v));
      });
    }
  }

  num? specialOrderId;
  num? amount;
  num? clientId;
  String? notes;
  num? specialOrderEnum;
  num? specialOrderStatus;
  bool? isNew;
  bool? submitted;
  num? offerAmount;
  String? specialOrderStatusName;
  String? specialOrderName;
  List<Media>? media;
  List<SpecialOrderAssigment>? specialOrderAssigment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['specialOrderId'] = specialOrderId;
    map['isNew'] = isNew;
    map['submitted'] = submitted;
    map['offerAmount'] = offerAmount;
    map['amount'] = amount;
    map['clientId'] = clientId;
    map['notes'] = notes;
    map['specialOrderEnum'] = specialOrderEnum;
    map['specialOrderStatus'] = specialOrderStatus;
    map['specialOrderStatusName'] = specialOrderStatusName;
    map['specialOrderName'] = specialOrderName;
    if (media != null) {
      map['media'] = media?.map((v) => v.toJson()).toList();
    }
    if (specialOrderAssigment != null) {
      map['specialOrderAssigment'] = specialOrderAssigment?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class SpecialOrderAssigment {
  SpecialOrderAssigment({
    this.specialOrderTechnicalAssignmentId,
    this.specialOrderId,
    this.technicalId,
    this.technicalName,
    this.technicalType,
    this.technicalTypeName,
  });

  SpecialOrderAssigment.fromJson(dynamic json) {
    specialOrderTechnicalAssignmentId = json['specialOrderTechnicalAssignmentId'];
    specialOrderId = json['specialOrderId'];
    technicalId = json['technicalId'];
    technicalName = json['technicalName'];
    technicalType = json['technicalType'];
    technicalTypeName = json['technicalTypeName'];
  }

  num? specialOrderTechnicalAssignmentId;
  num? specialOrderId;
  num? technicalId;
  String? technicalName;
  num? technicalType;
  String? technicalTypeName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['specialOrderTechnicalAssignmentId'] = specialOrderTechnicalAssignmentId;
    map['specialOrderId'] = specialOrderId;
    map['technicalId'] = technicalId;
    map['technicalName'] = technicalName;
    map['technicalType'] = technicalType;
    map['technicalTypeName'] = technicalTypeName;
    return map;
  }
}

class Media {
  final String src;
  final num mediaTypeEnum;

  Media({
    required this.src,
    required this.mediaTypeEnum,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      src: json['src'] ?? Constants.unKnownValue,
      mediaTypeEnum: json['mediaTypeEnum'] ?? -1,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['src'] = src;
    map['mediaTypeEnum'] = mediaTypeEnum;
    return map;
  }
}

import 'package:matlop_provider/feature/order/data/models/special_orders_model.dart';

class DetailsSpecialOrderModel {
  DetailsSpecialOrderModel({
    this.code,
    this.message,
    this.data,
  });

  DetailsSpecialOrderModel.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  num? code;
  dynamic message;
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
    this.specialOrderId,
    this.amount,
    this.clientId,
    this.clientName,
    this.notes,
    this.specialOrderEnum,
    this.specialOrderStatus,
    this.specialOrderStatusName,
    this.specialOrderName,
    this.media,
    this.specialOrderAssigment,
  });

  Data.fromJson(dynamic json) {
    specialOrderId = json['specialOrderId'];
    amount = json['amount'];
    clientId = json['clientId'];
    clientName = json['clientName'];
    notes = json['notes'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    specialOrderEnum = json['specialOrderEnum'];
    specialOrderStatus = json['specialOrderStatus'];
    specialOrderStatusName = json['specialOrderStatusName'];
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
  String? clientName;
  num? specialOrderEnum;
  num? specialOrderStatus;
  String? specialOrderStatusName;
  String? specialOrderName;
  List<Media>? media;
  List<SpecialOrderAssigment>? specialOrderAssigment;
  String? latitude;
  String? longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['specialOrderId'] = specialOrderId;
    map['amount'] = amount;
    map['clientId'] = clientId;
    map['clientName'] = clientName;
    map['notes'] = notes;
    map['longitude'] = longitude;
    map['latitude'] = latitude;
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

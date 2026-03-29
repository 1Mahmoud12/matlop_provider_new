import 'package:matlop_provider/feature/order/data/models/get_order_details_model.dart';

class OrderModel {
  int? code;
  String? message;
  List<OrderData>? data;

  OrderModel({
    this.code,
    this.message,
    this.data,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      code: json['code'] ?? -1,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)?.map((e) => OrderData.fromJson(e)).toList() ?? [],
    );
  }
}

class OrderData {
  int? orderId;
  int? clientId;
  String? clientName;
  int? paymentWayId;
  String? paymentWayName;
  int? packageId;
  String? packageName;
  int? cancelReasonId;
  String? orderCancelationNote;
  String? coponeName;
  int? coponeId;
  List<Media>? media;
  String? notes;
  int? locationId;
  String? locationName;
  String? orderStatusName;
  int? vistTimeId;
  String? nextVistDate;
  double? orderSubTotal;
  double? orderTotal;
  int? orderStatusEnum;
  Package? package;
  dynamic copones;
  List<OrderTechnicalAssignment>? orderTechnicalAssignments;
  dynamic orderScheduleDto;
  List<dynamic>? orderAddtionalItem;

  OrderData({
    this.orderId,
    this.clientId,
    this.clientName,
    this.paymentWayId,
    this.paymentWayName,
    this.packageId,
    this.packageName,
    this.cancelReasonId,
    this.orderCancelationNote,
    this.coponeName,
    this.coponeId,
    this.media,
    this.notes,
    this.locationId,
    this.locationName,
    this.orderStatusName,
    this.vistTimeId,
    this.nextVistDate,
    this.orderSubTotal,
    this.orderTotal,
    this.orderStatusEnum,
    this.package,
    this.copones,
    this.orderTechnicalAssignments,
    this.orderScheduleDto,
    this.orderAddtionalItem,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      orderId: json['orderId'] ?? -1,
      clientId: json['clientId'] ?? -1,
      clientName: json['clientName'] ?? '',
      paymentWayId: json['paymentWayId'] ?? -1,
      paymentWayName: json['paymentWayName'] ?? '',
      packageId: json['packageId'] ?? -1,
      packageName: json['packageName'] ?? '',
      cancelReasonId: json['cancelReasonId'],
      orderCancelationNote: json['orderCancelationNote'] ?? '',
      coponeName: json['coponeName'] ?? '',
      coponeId: json['coponeId'] ?? -1,
      media:           (json['media'] as List<dynamic>?)?.map((e) => Media.fromJson(e)).toList() ?? [],

      notes: json['notes'] ?? '',
      locationId: json['locationId'] ?? -1,
      locationName: json['locationName'] ?? '',
      orderStatusName: json['orderStatusName'] ?? '',
      vistTimeId: json['vistTimeId'] ?? -1,
      nextVistDate: json['nextVistDate'] ?? '',
      orderSubTotal: json['orderSubTotal'] ?? -1,
      orderTotal: json['orderTotal'] ?? -1,
      orderStatusEnum: json['orderStatusEnum'] ?? -1,
      package: json['package'] != null ? Package.fromJson(json['package']) : null,
      copones: json['copones'],
      orderTechnicalAssignments:
          (json['orderTechnicalAssignments'] as List<dynamic>?)?.map((e) => OrderTechnicalAssignment.fromJson(e)).toList() ?? [],
      orderScheduleDto: json['orderScheduleDto'],
      orderAddtionalItem: json['orderAddtionalItem'] ?? [],
    );
  }
}

class Package {
  int? packageId;
  String? nameEn;
  String? nameAr;
  String? descriptionEn;
  String? enInstraction;
  String? arInstraction;
  String? descriptionAr;
  int? workTimeId;
  int? providerNumber;
  int? visitNumber;
  double? visitHours;
  int? typeOfPackage;
  bool? isActive;
  dynamic contractTypeDto;
  int? contractTypeId;
  double? price;
  List<dynamic>? packageWorkTimes;

  Package({
    this.packageId,
    this.nameEn,
    this.nameAr,
    this.descriptionEn,
    this.enInstraction,
    this.arInstraction,
    this.descriptionAr,
    this.workTimeId,
    this.providerNumber,
    this.visitNumber,
    this.visitHours,
    this.typeOfPackage,
    this.isActive,
    this.contractTypeDto,
    this.contractTypeId,
    this.price,
    this.packageWorkTimes,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      packageId: json['packageId'] ?? -1,
      nameEn: json['nameEn'] ?? '',
      nameAr: json['nameAr'] ?? '',
      descriptionEn: json['descriptionEn'] ?? '',
      enInstraction: json['enInstraction'] ?? '',
      arInstraction: json['arInstraction'] ?? '',
      descriptionAr: json['descriptionAr'] ?? '',
      workTimeId: json['workTimeId'],
      providerNumber: json['providerNumber'] ?? -1,
      visitNumber: json['visitNumber'] ?? -1,
      visitHours: json['visitHours'] ?? -1,
      typeOfPackage: json['typeOfPackage'] ?? -1,
      isActive: json['isActive'] ?? false,
      contractTypeDto: json['contractTypeDto'],
      contractTypeId: json['contractTypeId'] ?? -1,
      price: json['price'] ?? -1,
      packageWorkTimes: json['packageWorkTimes'] ?? [],
    );
  }
}

class OrderTechnicalAssignment {
  int? orderTechnicalAssignmentId;
  int? orderId;
  int? technicalId;
  String? technicalName;
  int? technicalType;
  String? technicalTypeName;

  OrderTechnicalAssignment({
    this.orderTechnicalAssignmentId,
    this.orderId,
    this.technicalId,
    this.technicalName,
    this.technicalType,
    this.technicalTypeName,
  });

  factory OrderTechnicalAssignment.fromJson(Map<String, dynamic> json) {
    return OrderTechnicalAssignment(
      orderTechnicalAssignmentId: json['orderTechnicalAssignmentId'] ?? -1,
      orderId: json['orderId'] ?? -1,
      technicalId: json['technicalId'] ?? -1,
      technicalName: json['technicalName'] ?? '',
      technicalType: json['technicalType'] ?? -1,
      technicalTypeName: json['technicalTypeName'] ?? '',
    );
  }
}

class OrderDetailsModel {
  int? code;
  String? message;
  OrderDetailsData? data;

  OrderDetailsModel({this.code, this.message, this.data});

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
      code: json['statusCode'] ?? json['code'] ?? -1,
      message: json['message'] ?? '',
      data: json['data'] != null ? OrderDetailsData.fromJson(json['data']) : null,
    );
  }
}

class OrderDetailsData {
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
  num? orderSubTotal;
  String? latitude;
  String? longitude;
  num? orderTotal;
  int? orderStatusEnum;
  Package? package;
  dynamic copones;
  List<OrderTechnicalAssignment>? orderTechnicalAssignments;
  dynamic orderScheduleDto;
  List<dynamic>? orderAddtionalItem;
  List<OrderEquipment>? orderEquipment;
  num? taxAmount;
  num? taxPercentageSnapshot;
  String? taxNameSnapshot;
  List<OrderSchedule>? orderSchedules;

  OrderDetailsData({
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
    this.latitude,
    this.longitude,
    this.orderEquipment,
    this.taxAmount,
    this.taxPercentageSnapshot,
    this.taxNameSnapshot,
    this.orderSchedules,
  });

  factory OrderDetailsData.fromJson(Map<String, dynamic> json) {
    return OrderDetailsData(
      orderId: json['orderId'] ?? -1,
      clientId: json['clientId'] ?? -1,
      clientName: json['clientName'] ?? '',
      paymentWayId: json['paymentMethodId'] ?? json['paymentWayId'] ?? -1,
      latitude: json['latitude'] ?? -1,
      longitude: json['longitude'] ?? -1,
      paymentWayName: json['paymentMethodName'] ?? json['paymentWayName'] ?? '',
      packageId: json['packageId'] ?? -1,
      packageName: json['packageName'] ?? '',
      cancelReasonId: json['cancelReasonId'],
      orderCancelationNote: json['orderCancelationNote'] ?? '',
      coponeName: json['coponeName'] ?? '',
      coponeId: json['coponeId'] ?? -1,
      media: ((json['orderMedias'] ?? json['media']) as List<dynamic>?)?.map((e) => Media.fromJson(e)).toList() ?? [],
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
          ((json['technicalAssignments'] ?? json['orderTechnicalAssignments']) as List<dynamic>?)?.map((e) => OrderTechnicalAssignment.fromJson(e)).toList() ?? [],
      orderScheduleDto: json['orderSchedules'] ?? json['orderScheduleDto'],
      orderAddtionalItem: json['additionalItems'] ?? json['orderAddtionalItem'] ?? [],
      orderEquipment: (json['orderEquipment'] as List<dynamic>?)?.map((e) => OrderEquipment.fromJson(e)).toList() ?? [],
      taxAmount: json['taxAmount'] ?? 0,
      taxPercentageSnapshot: json['taxPercentageSnapshot'] ?? 0,
      taxNameSnapshot: json['taxNameSnapshot'] ?? '',
      orderSchedules: (json['orderSchedules'] as List<dynamic>?)?.map((e) => OrderSchedule.fromJson(e)).toList() ?? [],
    );
  }
}

class OrderSchedule {
  int? orderScheduleId;
  String? visitDate;
  bool? isCompleted;
  bool? isCompletedVisit;

  OrderSchedule({
    this.orderScheduleId,
    this.visitDate,
    this.isCompleted,
    this.isCompletedVisit,
  });

  factory OrderSchedule.fromJson(Map<String, dynamic> json) {
    return OrderSchedule(
      orderScheduleId: json['orderScheduleId'] ?? -1,
      visitDate: json['visitDate'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
      isCompletedVisit: json['isCompletedVisit'] ?? false,
    );
  }
}

class Media {
  String? src;
  int? mediaTypeEnum;

  Media({this.src, this.mediaTypeEnum});

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      src: json['src'] ?? '',
      mediaTypeEnum: json['mediaTypeEnum'] ?? -1,
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
  num? visitHours;
  int? typeOfPackage;
  bool? isActive;
  dynamic contractTypeDto;
  int? contractTypeId;
  num? price;
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

class OrderEquipment {
  int? orderEquipmentId;
  int? equipmentId;
  int? orderId;
  String? arName;
  String? enName;
  num? price;
  String? image;

  OrderEquipment({
    this.orderEquipmentId,
    this.equipmentId,
    this.orderId,
    this.arName,
    this.enName,
    this.price,
    this.image,
  });

  factory OrderEquipment.fromJson(Map<String, dynamic> json) {
    return OrderEquipment(
      orderEquipmentId: json['orderEquipmentId'] ?? -1,
      equipmentId: json['equipmentId'] ?? -1,
      orderId: json['orderId'] ?? -1,
      arName: json['arName'] ?? '',
      enName: json['enName'] ?? '',
      price: json['price'] ?? 0,
      image: json['image'] ?? '',
    );
  }
}

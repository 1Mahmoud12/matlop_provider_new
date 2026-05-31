class TechnicalSpecialListModel {
  TechnicalSpecialListModel({
    this.isSuccess,
    this.statusCode,
    this.message,
    this.data,
  });

  TechnicalSpecialListModel.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ItemTechnicalSpecialListModel.fromJson(v));
      });
    }
  }

  bool? isSuccess;
  int? statusCode;
  String? message;
  List<ItemTechnicalSpecialListModel>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isSuccess'] = isSuccess;
    map['statusCode'] = statusCode;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ItemTechnicalSpecialListModel {
  ItemTechnicalSpecialListModel({
    this.technicalSpecialistId,
    this.enName,
    this.arName,
    this.enDescription,
    this.arDescription,
    this.numOfTechnicals,
    this.image,
    this.priorityView,
    this.isActive,
  });

  ItemTechnicalSpecialListModel.fromJson(dynamic json) {
    technicalSpecialistId = json['technicalSpecialistId'] ?? json['serviceId'];
    enName = json['enName'];
    arName = json['arName'];
    enDescription = json['enDescription'];
    arDescription = json['arDescription'];
    numOfTechnicals = json['numOfTechnicals'];
    image = json['image'];
    priorityView = json['priorityView']?.toString();
    isActive = json['isActive'];
  }

  int? technicalSpecialistId;
  String? enName;
  String? arName;
  String? enDescription;
  String? arDescription;
  int? numOfTechnicals;
  String? image;
  String? priorityView;
  bool? isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['technicalSpecialistId'] = technicalSpecialistId; // Also handles serviceId
    map['enName'] = enName;
    map['arName'] = arName;
    map['enDescription'] = enDescription;
    map['arDescription'] = arDescription;
    map['numOfTechnicals'] = numOfTechnicals;
    map['image'] = image;
    map['priorityView'] = priorityView;
    map['isActive'] = isActive;
    return map;
  }
}

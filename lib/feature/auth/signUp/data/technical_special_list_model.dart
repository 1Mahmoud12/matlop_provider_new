class TechnicalSpecialListModel {
  TechnicalSpecialListModel({
    this.code,
    this.message,
    this.data,
  });

  TechnicalSpecialListModel.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ItemTechnicalSpecialListModel.fromJson(v));
      });
    }
  }

  int? code;
  String? message;
  List<ItemTechnicalSpecialListModel>? data;

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

class ItemTechnicalSpecialListModel {
  ItemTechnicalSpecialListModel({
    this.technicalSpecialistId,
    this.enName,
    this.arName,
  });

  ItemTechnicalSpecialListModel.fromJson(dynamic json) {
    technicalSpecialistId = json['technicalSpecialistId'];
    enName = json['enName'];
    arName = json['arName'];
  }

  int? technicalSpecialistId;
  String? enName;
  String? arName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['technicalSpecialistId'] = technicalSpecialistId;
    map['enName'] = enName;
    map['arName'] = arName;
    return map;
  }
}

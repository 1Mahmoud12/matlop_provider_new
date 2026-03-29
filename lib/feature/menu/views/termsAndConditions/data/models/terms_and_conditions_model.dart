class TermsAndConditionsModel {
  TermsAndConditionsModel({
      this.code, 
      this.message, 
      this.data,});

  TermsAndConditionsModel.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  int? code;
  String? message;
  List<Data>? data;

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

class Data {
  Data({
      this.termId, 
      this.enName, 
      this.arName, 
      this.enDescription, 
      this.arDescription, 
      this.userType,});

  Data.fromJson(dynamic json) {
    termId = json['termId'];
    enName = json['enName'];
    arName = json['arName'];
    enDescription = json['enDescription'];
    arDescription = json['arDescription'];
    userType = json['userType'];
  }
  int? termId;
  String? enName;
  String? arName;
  String? enDescription;
  String? arDescription;
  int? userType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['termId'] = termId;
    map['enName'] = enName;
    map['arName'] = arName;
    map['enDescription'] = enDescription;
    map['arDescription'] = arDescription;
    map['userType'] = userType;
    return map;
  }

}
class PrivacyAndPolicyModel {
  PrivacyAndPolicyModel({
      this.code, 
      this.message, 
      this.data,});

  PrivacyAndPolicyModel.fromJson(dynamic json) {
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
      this.policyId, 
      this.enTitle, 
      this.arTitle, 
      this.enDescription, 
      this.arDescription, 
      this.userType,});

  Data.fromJson(dynamic json) {
    policyId = json['policyId'];
    enTitle = json['enTitle'];
    arTitle = json['arTitle'];
    enDescription = json['enDescription'];
    arDescription = json['arDescription'];
    userType = json['userType'];
  }
  int? policyId;
  String? enTitle;
  String? arTitle;
  String? enDescription;
  String? arDescription;
  int? userType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['policyId'] = policyId;
    map['enTitle'] = enTitle;
    map['arTitle'] = arTitle;
    map['enDescription'] = enDescription;
    map['arDescription'] = arDescription;
    map['userType'] = userType;
    return map;
  }

}
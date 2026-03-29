class CommonQuestionModel {
  int? code;
  String? message;
  List<QuestionData>? data;

  CommonQuestionModel({
    this.code,
    this.message,
    this.data,
  });

  factory CommonQuestionModel.fromJson(Map<String, dynamic> json) {
    return CommonQuestionModel(
      code: json['code'],
      message: json['message']??'no data found',
      data:json['data']!=null? List<QuestionData>.from(
        json['data'].map((item) => QuestionData.fromJson(item)),
      ):[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }
}

class QuestionData {
  num? questionId;
  String? enTitle;
  String? arTitle;
  String? enDescription;
  String? arDescription;
  num? userType;

  QuestionData({
    this.questionId,
    this.enTitle,
    this.arTitle,
    this.enDescription,
    this.arDescription,
    this.userType,
  });

  factory QuestionData.fromJson(Map<String, dynamic> json) {
    return QuestionData(
      questionId: json['questionId'],
      enTitle: json['enTitle'],
      arTitle: json['arTitle'],
      enDescription: json['enDescription'],
      arDescription: json['arDescription'],
      userType: json['userType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'enTitle': enTitle,
      'arTitle': arTitle,
      'enDescription': enDescription,
      'arDescription': arDescription,
      'userType': userType,
    };
  }
}

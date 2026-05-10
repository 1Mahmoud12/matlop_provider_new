class WorkerTypeModel {
  WorkerTypeModel({this.data, this.isSuccess});

  WorkerTypeModel.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(WorkerTypeItem.fromJson(v));
      });
    }
  }

  bool? isSuccess;
  List<WorkerTypeItem>? data;
}

class WorkerTypeItem {
  WorkerTypeItem({
    this.id,
    this.enName,
    this.arName,
    this.code,
    this.price,
    this.isActive,
  });

  WorkerTypeItem.fromJson(dynamic json) {
    id = json['id'];
    enName = json['enName'];
    arName = json['arName'];
    code = json['code'];
    price = (json['price'] as num?)?.toDouble();
    isActive = json['isActive'];
  }

  int? id;
  String? enName;
  String? arName;
  String? code;
  double? price;
  bool? isActive;
}

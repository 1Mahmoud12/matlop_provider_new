import 'package:equatable/equatable.dart';

class TechnicalServiceData extends Equatable {
  final int serviceId;
  final String arName;
  final String enName;

  const TechnicalServiceData({
    required this.serviceId,
    required this.arName,
    required this.enName,
  });

  factory TechnicalServiceData.fromJson(Map<String, dynamic> json) {
    return TechnicalServiceData(
      serviceId: json['serviceId'] ?? 0,
      arName: json['serviceArName'] ?? '',
      enName: json['serviceEnName'] ?? '',
    );
  }

  @override
  List<Object?> get props => [serviceId, arName, enName];
}

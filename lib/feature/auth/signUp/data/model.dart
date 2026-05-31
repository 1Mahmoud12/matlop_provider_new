class SingUpParameters {
  final String fullName;
  final String email;
  final String username;
  final String password;
  final String phone;
  final int genderId;
  final int technicalTypeEnum;
  final int? technicalSpecialistId;
  final List<int> technicalServiceIds;
  final int? workerTypeId;

  SingUpParameters({
    required this.fullName,
    required this.username,
    required this.email,
    required this.password,
    required this.phone,
    required this.technicalTypeEnum,
    required this.technicalSpecialistId,
    required this.technicalServiceIds,
    this.workerTypeId,
    this.genderId = 1,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'userName': username,
      'email': email,
      'password': password,
      'mobileNumber': '0$phone',
      'genderId': genderId,
      'roleType': technicalTypeEnum,
      'technicalSpecialistId': technicalSpecialistId ?? 0,
      'technicalServiceIds': technicalServiceIds,
      'workerTypeId': workerTypeId,
    };
  }
}
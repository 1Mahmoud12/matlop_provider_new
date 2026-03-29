class SingUpParameters {
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String password;
  final String phone;
  final String nationalNo;
  final int countryId;
  final int userTypeId;
  final int technicalTypeEnum;
  final int technicalSpecialistId;

  SingUpParameters({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.password,
    required this.phone,
    required this.nationalNo,
    required this.countryId,
    required this.technicalTypeEnum,
    required this.technicalSpecialistId,
    required this.userTypeId,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': firstName,
      'username': username,
      'email': email,
      // 'password': password,
      'mobileNumber': '0$phone',
      'nationalNo': nationalNo,
      'genderId': 1,
      'technicalType': technicalTypeEnum,
      'userTypeId': userTypeId,
      'technicalCategoryId': technicalSpecialistId,
    };
  }
}

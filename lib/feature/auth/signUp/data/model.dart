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
  final int technicalCategoryId;
  final List<int> technicalServiceIds;

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
    required this.technicalCategoryId,
    required this.technicalServiceIds,
    required this.userTypeId,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'userName': username,
      'email': email,
      'password': password,
      'mobileNumber': '0$phone',
      // 'nationalNo': nationalNo, // the curl doesn't mention nationalNo, but keeping it if needed, wait curl has no national no? I'll just map curl exactly + what we had
      'genderId': 1,
      'technicalCategoryId': technicalCategoryId,
      'technicalType': technicalTypeEnum,
      'technicalServiceIds': technicalServiceIds,
    };
  }
}

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
  final int genderId;

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
    this.genderId = 1, // default: male
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'userName': username,
      'email': email,
      'password': password,
      'mobileNumber': '0$phone',
      'genderId': genderId,
      'technicalCategoryId': technicalCategoryId,
      'technicalType': technicalTypeEnum,
      'technicalServiceIds': technicalServiceIds,
    };
  }
}


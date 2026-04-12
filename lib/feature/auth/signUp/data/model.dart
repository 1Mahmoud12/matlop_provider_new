class SingUpParameters {
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String password;
  final String phone;
  final int countryId;
  final int technicalTypeEnum;
  final List<int> technicalServiceIds;
  final int genderId;

  SingUpParameters({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.password,
    required this.phone,
    required this.countryId,
    required this.technicalTypeEnum,
    required this.technicalServiceIds,
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
      'roleId': technicalTypeEnum,
      'technicalServiceIds': technicalServiceIds,
      "isTechnical": true,

    };
  }
}


import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:matlop_provider/core/network/local/cache.dart';


class UpdateProfileParams {
  final int userId;
  final String firstName;
  final String lastName;
  final String username;
  final String mobileNumber;
  final String dateOfBirth;
  final File? imgSrc;
  final int gender;
  final int technicalSpecialistId;
  final String email;

  UpdateProfileParams({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.mobileNumber,
    required this.dateOfBirth,
    required this.imgSrc,
    required this.gender,
    required this.email,
    required this.technicalSpecialistId,
  });

  Future<Map<String, Object>> toJson() async {
    try {
      final Map<String, Object> jsonData = {
        'userId': userId,
        'userTypeId': profileCacheValue?.data?.userTypeId ?? 0,
        'firstName': firstName,
        'lastName': lastName,
        'username': username,
        'mobileNumber': mobileNumber,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        'email': email,
        "isActive": true,
        'technicalSpecialistId': technicalSpecialistId,
      };

      // Check if imgSrc is not null and convert to base64 if present
      if (imgSrc != null) {
        try {
          final imgBytes = await imgSrc!.readAsBytes();
          jsonData['imgSrc'] = 'data:image/${imgSrc?.path.split('/').last.split('.').last};base64,${base64Encode(
            imgBytes,
          )}';
        } catch (e) {
          log('Error encoding image: $e');
        }
      }

      return jsonData;
    } catch (e) {
      log('Error in toJson method: $e');
      rethrow;
    }
  }
}

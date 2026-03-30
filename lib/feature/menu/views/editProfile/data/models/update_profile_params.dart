import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:matlop_provider/core/network/local/cache.dart';

class UpdateProfileParams {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final File? imgSrc;
  final int genderId;

  UpdateProfileParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNumber,
    required this.genderId,
    this.imgSrc,
  });

  Future<Map<String, Object>> toJson() async {
    try {
      // Always include imgSrc — fall back to the cached profile image URL
      // so the field is never missing from the request body.
      String imgSrcValue = profileCacheValue?.data?.imgSrc ?? '';

      // If a new image was picked, encode it as base64 and override the URL.
      if (imgSrc != null) {
        try {
          final imgBytes = await imgSrc!.readAsBytes();
          final ext = imgSrc!.path.split('.').last.toLowerCase();
          const mimeMap = {
            'jpg': 'jpeg',
            'jpeg': 'jpeg',
            'png': 'png',
            'gif': 'gif',
            'webp': 'webp',
            'bmp': 'bmp',
            'heic': 'heic',
          };
          final mimeType = mimeMap[ext] ?? 'jpeg';
          imgSrcValue = 'data:image/$mimeType;base64,${base64Encode(imgBytes)}';
        } catch (e) {
          log('Error encoding image: $e');
        }
      }

      return {
        'userId': profileCacheValue?.data?.userId ?? 0,
        'firstName': firstName,
        'lastName': 'lastName',
        'email': email,
        'mobileNumber': mobileNumber,
        'genderId': genderId,
        'imgSrc': imgSrcValue, // always present
      };
    } catch (e) {
      log('Error in toJson method: $e');
      rethrow;
    }
  }
}
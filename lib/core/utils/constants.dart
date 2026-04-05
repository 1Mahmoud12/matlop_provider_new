import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:matlop_provider/feature/chat/presentation/manager/messageCubit/message_cubit.dart';
import 'package:matlop_provider/feature/menu/views/editProfile/data/models/country_model.dart';
import 'package:matlop_provider/feature/addNewAddress/data/models/country_model.dart' as add_new_address_country;

class Constants {
  static String fontFamily = 'Montserrat';
  static bool user = true;
  static String serviceNumber = '0508991360';

  // static LatLng cairoLatLng = const LatLng(30.033333, 31.233334);
  static String locationCache = '';
  static String token = '';
  static bool tablet = false;
  static String unKnownValue = 'Un Known Value'.tr();
  static String notificationChannelKey = 'channel_id3';
  static LatLng saudiLatLng = const LatLng(24.7248316, 47.152177);

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String fcmToken = '';
  static String deviceId = '';
  static String currentLanguage = 'en';
  static String passwordApi = r'#as@$#$@as#';
  static Map jsonServerKey = {};
  static List<String> selectedStatus = ['In Progress'.tr(), 'Completed'.tr(), 'Cancelled'.tr()];
  static List<String> orderType = ['Emergency Order'.tr(), 'Special Order'.tr()];
  static RemoteMessage? messageGlobal;
  
  static int? selectedCountryId;
  static add_new_address_country.CountryData? myCountry;

  static List<Country> countries = [
    Country(flag: '🇺🇸', code: '+1'), // United States
    Country(flag: '🇬🇧', code: '+44'), // United Kingdom
    Country(flag: '🇸🇦', code: '+966'), // Saudi Arabia
    Country(flag: '🇮🇳', code: '+91'), // India
    Country(flag: '🇪🇬', code: '+20'), // Egypt
    // Add more countries here...
  ];

// static RemoteMessage? messageGlobal;
}

void showAttachmentOptions(BuildContext context, MessageCubit chatCubit, {required String userId}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Select Image'),
              onTap: () {
                chatCubit.pickImage(context, userId: userId);
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.attach_file),
            //   title: const Text('Select File'),
            //   onTap: () async {
            //     await chatCubit.pickOtherFiles(context);
            //   },
            // ),
          ],
        ),
      );
    },
  );
}

enum StatusRequest { completed, pending, canceled }

bool arabicLanguage = true;

class IconAndText {
  final String icon;
  final String text;

  IconAndText({required this.icon, required this.text});
}

enum ContactMethods { whatsapp, email, call, meeting, project }

enum Gender { other, male, female }

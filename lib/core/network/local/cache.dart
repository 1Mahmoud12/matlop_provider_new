import 'package:hive_flutter/adapters.dart';
import 'package:matlop_provider/feature/auth/login/data/models/login_model.dart';
import 'package:matlop_provider/feature/menu/views/editProfile/data/models/profile_model.dart';

Box? userCache;
String userCacheBoxKey = 'userCache';
// keys
String countryIdKey = 'countryIdKey';

String sliderValueKey = 'slider_value_key';
String hoursWorkedKey = 'hours_worked_key';
String rememberMeKey = 'rememberMeKey';
String onBoardingKey = 'onBoardingKey';
String userCacheKey = 'userCacheKey';
String languageKey = 'languageKey';
String profileCacheKey = 'profileCacheKey';
String checkInKey = 'checkInKey';
String fcmTokenKey = 'fcmTokenKey';
String deviceIdKey = 'deviceIdKey';
// value
bool onBoardingValue = true;
bool rememberMe = false;
bool checkInCache = false;
LoginModel? userCacheValue;
ProfileModel? profileCacheValue;

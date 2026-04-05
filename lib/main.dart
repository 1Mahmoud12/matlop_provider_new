import 'dart:convert';
import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:logger/logger.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/core/utils/notification/notification.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/manager/addNewAddress/cubit/add_new_address_cubit.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/manager/getCitiesCubit/city_cubit.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/manager/getCountriesCubit/country_cubit.dart';
import 'package:matlop_provider/feature/auth/forgetPassword/manager/resetCubit/reset_password_cubit.dart';
import 'package:matlop_provider/feature/bottomNavBarScreen/bottom_nav_bar_view.dart';
import 'package:matlop_provider/feature/bottomNavBarScreen/presentation/manager/cubit/bottom_nav_bar_cubit.dart';
import 'package:matlop_provider/feature/chat/presentation/manager/messageCubit/message_cubit.dart';
import 'package:matlop_provider/feature/menu/presentation/manager/cubit/menu_cubit.dart';
import 'package:matlop_provider/feature/menu/views/wallet/presentation/manager/walletCubit/cubit/wallet_cubit.dart';
import 'package:matlop_provider/feature/order/presentation/manager/cubit/order_cubit.dart';
import 'package:matlop_provider/feature/order/presentation/manager/specialrderCubit/special_order_cubit.dart';
import 'package:matlop_provider/feature/splashScreen/view/presentation/splash_screen.dart';
import 'package:matlop_provider/firebase_options.dart';

import 'core/network/dio_helper.dart';
import 'core/network/local/cache.dart';
import 'core/network/local/hive_data_base.dart';
import 'core/themes/light.dart';
import 'core/utils/bloc_observe.dart';
import 'feature/auth/login/data/models/login_model.dart';
import 'feature/menu/views/editProfile/data/models/profile_model.dart';

Widget appStartScreen = const SplashScreenOne();
final navigatorKey = GlobalKey<NavigatorState>();
final Logger logger = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableBuildModes = [];
  // Hive
  await Hive.initFlutter();
  // dio
  await DioHelper.init();

  userCache = await openHiveBox(userCacheBoxKey);

  onBoardingValue = userCache?.get(onBoardingKey, defaultValue: true);
  arabicLanguage = userCache?.get(languageKey, defaultValue: true);
  userCacheValue = LoginModel.fromJson(jsonDecode(await userCache!.get(userCacheKey, defaultValue: '{}')));
  Constants.token = userCacheValue?.data?.accessToken ?? '';

  // Load profile cache so Home screen shows the correct image immediately on startup
  final profileJson = await userCache!.get(profileCacheKey, defaultValue: '{}');
  if (profileJson != '{}') {
    try {
      profileCacheValue = ProfileModel.fromJson(jsonDecode(profileJson));
    } catch (_) {
      profileCacheValue = null;
    }
  }
  // Constants.user = userCacheValue?.data?.type == 'developer';
  // checkInCache = userCache?.get(checkInKey, defaultValue: false);
  log('user id ======> ${userCacheValue?.data?.userId}');
  log('user token ======> ${userCacheValue?.data?.accessToken}');
  logger.f('arabicLanguage ======> $arabicLanguage');

  Bloc.observer = MyBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationUtility.initializeAwesomeNotification();
  try {
    Constants.messageGlobal = await FirebaseMessaging.instance.getInitialMessage();
    if (Constants.messageGlobal?.data != null) {
      appStartScreen = const BottomNavBarView();
    }
    log('appStartScreen $appStartScreen');
  } catch (error) {
    log('$error');
  }
  // selectTokens is called from LoginCubit after successful login
  // Constants.jsonServerKey = await loadJsonFile();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) {
        return EasyLocalization(
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('ar', 'SA'),
          ],
          path: 'assets/translation',
          startLocale: const Locale('ar', 'SA'),
          child: const MyApp(),
        );
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;

  @override
  void didChangeDependencies() async {
    if (currentIndex == 0) {
      await initNotification();
      currentIndex++;
    }
    super.didChangeDependencies();
  }

  Future<void> initNotification() async {
    await Future.delayed(Duration.zero, () async {
      //setup notification callback here
      if (context.mounted) {
        await NotificationUtility.setUpNotificationService(context);
      }
    });

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationUtility.onActionReceivedMethod,
      onNotificationCreatedMethod: NotificationUtility.onNotificationCreatedMethod,
      onNotificationDisplayedMethod: NotificationUtility.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: NotificationUtility.onDismissActionReceivedMethod,
    );

    notificationTerminatedBackground();
  }

  void notificationTerminatedBackground() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      debugPrint('Global Message ${Constants.messageGlobal?.data}');
      if (Constants.messageGlobal?.data != null) {
        debugPrint('Global Message Enter${Constants.messageGlobal?.data}');

        Future.delayed(const Duration(milliseconds: 1000), () async {
          NotificationUtility.onTapNotificationScreenNavigateCallback(
            Constants.messageGlobal!.data['type'] ?? '',
            Constants.messageGlobal!.data,
          );
          Constants.messageGlobal = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    arabicLanguage = context.locale.toString() == 'ar_SA';
    Constants.tablet = MediaQuery.of(context).size.width > 600;
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(360, 840),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => BottomNavBarCubit()),
          BlocProvider(create: (_) => MenuCubit()),
          BlocProvider(create: (_) => AddNewAddressCubit()),
          BlocProvider(lazy: false, create: (_) => CountryCubit()..getCountries(context)),
          BlocProvider(create: (_) => ResetPasswordCubit()),
          BlocProvider(create: (_) => OrderCubit()),
          BlocProvider(create: (_) => SpecialOrderCubit()),
          BlocProvider(create: (_) => WalletCubit()),
          BlocProvider(create: (_) => MessageCubit()),
          BlocProvider(
            create: (context) => CityCubit(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          navigatorKey: navigatorKey,

          //locale: DevicePreview.locale(context),
          //builder: DevicePreview.appBuilder,
          theme: light,
          home: const SplashScreenOne(),
        ),
      ),
    );
  }
}

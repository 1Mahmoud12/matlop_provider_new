import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/themes/styles.dart';
import 'package:matlop_provider/core/utils/app_images.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/feature/auth/login/presentation/login_view.dart';
import 'package:matlop_provider/feature/auth/login/presentation/manager/cubit/login_cubit.dart';
import 'package:matlop_provider/feature/bottomNavBarScreen/bottom_nav_bar_view.dart';
import 'package:matlop_provider/feature/onBoarding/presentation/on_boarding_screen.dart';

class SplashScreenOne extends StatefulWidget {
  const SplashScreenOne({super.key});

  @override
  State<SplashScreenOne> createState() => _SplashScreenOneState();
}

class _SplashScreenOneState extends State<SplashScreenOne> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    //currentLocation();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    timer = Timer(
      const Duration(seconds: 3),
      () {
        //context.navigateToPage(const LoginView());
        if (onBoardingValue) {
          runAnimation = true;
          setState(() {});
          //context.navigateToPage(const OnBoardingScreen());
        } else {
          //   // context.navigateToPageWithClearStack(
          //   //   userCacheValue?.data == null ? const AddPasswordScreen() : const NavBArScreens(),
          //   // );
          //   context.navigateToPage(const BottomNavBarScreen());
          // }
          //  Utils.setStatusAndNavigationBarMethod(context);
          //     : const LoginScreen());

          context.navigateToPage(
              userCacheValue?.data != null ? const BottomNavBarView() : BlocProvider(create: (_) => LoginCubit(), child: const LoginView()));

          // context.navigateToPage(const BottomNavBarScreen());
        }
        userCache?.put(onBoardingKey, false);
      },
    );
  }

/*  String? long;
  String? lat;

  void currentLocation() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      try {
        final Position position = await Geolocator.getCurrentPosition();
        lat = position.latitude.toString();
        long = position.longitude.toString();
        appCacheBox!.put(latCacheName, lat);
        appCacheBox!.put(longCacheName, long);
        latCache = lat;
        longCache = long;
      } catch (e) {
        return;
      }
    } else {}
  }*/

  @override
  void dispose() {
    controller.dispose(); // Dispose the AnimationController
    timer.cancel(); // Cancel the Timer
    super.dispose();
  }

  bool runAnimation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackGround,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ClipOval(
              child: Image.asset(
                AppImages.logo,
                height: 200,
                width: 200,
              ),
            ),
          ),
          //const SizedBox(height: 50),
          AnimatedContainer(
            duration: Durations.extralong4,
            height: runAnimation ? 200 : 0,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: AnimatedOpacity(
              duration: Durations.extralong4,
              opacity: runAnimation ? 1 : 0,
              child: Column(
                children: [
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextButton(
                          child: Text(
                            'العربيه',
                            style: Styles.style16600.copyWith(color: AppColors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPress: () {
                            context.setLocale(const Locale('ar', 'SA'));
                            setState(() {});
                            context.navigateToPage(const OnBoardingScreen());
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextButton(
                          child: Text(
                            'English',
                            style: Styles.style16600.copyWith(color: AppColors.white),
                            textAlign: TextAlign.center,
                          ),
                          onPress: () {
                            context.setLocale(const Locale('en', 'US'));
                            setState(() {});
                            context.navigateToPage(const OnBoardingScreen());
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

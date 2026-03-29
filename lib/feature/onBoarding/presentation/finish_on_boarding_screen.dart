import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/themes/styles.dart';
import 'package:matlop_provider/core/utils/app_images.dart';
import 'package:matlop_provider/core/utils/extensions.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/feature/auth/login/presentation/login_view.dart';
import 'package:matlop_provider/feature/auth/login/presentation/manager/cubit/login_cubit.dart';
import 'package:matlop_provider/feature/auth/userType/user_type.dart';

class FinishOnBoardingScreen extends StatelessWidget {
  const FinishOnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.asset(
                AppImages.finishOnboarding,
                fit: BoxFit.fill,
                height: context.screenHeight * .6,
                width: double.infinity,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                height: context.screenHeight * .2,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0),
                      Colors.white.withOpacity(.8),
                      Colors.white,
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              //  mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: AppColors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //   const Spacer(),
                      Text.rich(
                        TextSpan(
                          text: 'Welcome to in'.tr(),
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Tajawal',
                          ),
                          children: [
                            TextSpan(
                              text: ' ',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                            TextSpan(
                              text: context.locale.languageCode == 'en' ? 'Matlop' : 'مطلوب'.tr(),
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Login or sign up for maintenance services with ease and speed!'.tr(),
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextButton(
                        gradientColors: true,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Create An Account'.tr(),
                              textAlign: TextAlign.center,
                              style: Styles.style16700.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                          ],
                        ),
                        onPress: () {
                          context.navigateToPage(
                            const UserTypeView(),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomTextButton(
                        backgroundColor: AppColors.white,
                        borderColor: AppColors.cNewColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Login'.tr(),
                              textAlign: TextAlign.center,
                              style: Styles.style16700.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.cNewColor,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                          ],
                        ),
                        onPress: () {
                          context.navigateToPage(
                            BlocProvider(
                              create: (context) => LoginCubit(),
                              child: const LoginView(),
                            ),
                          );
                        },
                      ),
                      // const SizedBox(
                      //   height: 12,
                      // ),
                      // CustomTextButton(
                      //   backgroundColor: AppColors.transparent,
                      //   borderColor: AppColors.transparent,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Text(
                      //         'Continue as a visitor'.tr(),
                      //         textAlign: TextAlign.center,
                      //         style: Styles.style16700
                      //             .copyWith(fontWeight: FontWeight.w500, color: AppColors.primaryColor, decoration: TextDecoration.underline),
                      //       ),
                      //     ],
                      //   ),
                      //   onPress: () {
                      //     context.navigateToPageWithReplacement(const BottomNavBarScreen());
                      //   },
                      // ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

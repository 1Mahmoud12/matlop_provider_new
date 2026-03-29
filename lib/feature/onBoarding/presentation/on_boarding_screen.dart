import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/themes/styles.dart';
import 'package:matlop_provider/core/utils/app_images.dart';
import 'package:matlop_provider/core/utils/dot_indicator_widget.dart';
import 'package:matlop_provider/core/utils/extensions.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/feature/onBoarding/presentation/finish_on_boarding_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController();
  int indexPage = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (context.locale.languageCode == 'ar') {
          images.addAll([
            AppImages.onboarding1,
            AppImages.onboarding2,
            AppImages.onboarding3,
            AppImages.onboarding4,
          ]);
        } else {
          images.addAll([
            AppImages.onboardingEn1,
            AppImages.onboardingEn2,
            AppImages.onboardingEn3,
            AppImages.onboardingEn4,
          ]);
        }
        setState(() {});
      },
    );
  }

  final List<String> images = [];

  @override
  Widget build(BuildContext context) {
    final List<String> title = [
      'One place for all maintenance services',
      'Flexible prices and excellent services.',
      'Track your orders with ease.',
      'Ready for an easier maintenance experience?',
      'Discover the features of your estate',
    ];
    final List<String> subTitle = [
      'We provide you with all maintenance services, from plumbing and electricity to air conditioning and emergency repairs, quickly and easily.',
      'Our packages offer you the best prices with professional services, whether you need monthly, quarterly, or annual maintenance.',
      'Track the status of your maintenance requests step by step through the app and receive notifications with updates.',
      'Request the service now and enjoy professional, fast, and convenient maintenance solutions anytime!',
      'Discover the features of your estate',
    ];

    //   Utils.setStatusAndNavigationBarMethod(context);

    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.black,

        body: Column(
          children: [
            Directionality(
              textDirection: context.locale.languageCode == 'ar' ? TextDirection.ltr : TextDirection.rtl,
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        context.navigateToPage(const FinishOnBoardingScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 25, right: 16, left: 16),
                        child: Text(
                          'skip'.tr(),
                          textAlign: TextAlign.center,
                          style: Styles.style16700.copyWith(fontWeight: FontWeight.w500, color: AppColors.black, fontFamily: 'Tajawal'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: context.screenHeight * .54,
                      child: PageView.builder(
                        onPageChanged: (value) {
                          indexPage = value;
                          setState(() {});
                          if (indexPage == 6) {
                            Future.delayed(
                              const Duration(seconds: 2),
                              () => context.navigateToPage(const FinishOnBoardingScreen()),
                            );
                          }
                        },
                        controller: pageController,
                        itemBuilder: (context, index) => Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Image.asset(
                              height: context.screenHeight * .56,
                              width: double.infinity,
                              images[index],
                            ),
                            Container(
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
                        itemCount: images.length,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            title[indexPage].tr(),
                            textAlign: TextAlign.center,
                            style: Styles.style22800.copyWith(color: AppColors.black, fontFamily: 'Tajawal'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            subTitle[indexPage].tr(),
                            textAlign: TextAlign.center,
                            style: Styles.style16600.copyWith(fontWeight: FontWeight.w400, color: AppColors.black, fontFamily: 'Tajawal'),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...List.generate(
                                images.length,
                                (indexList) =>
                                    DotIndicator(selectedColor: indexPage == indexList ? AppColors.textColor : AppColors.cUnSelectedColorIndicator),
                              ),
                            ].paddingDirectional(end: 5, start: 5),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: CustomTextButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'follow'.tr(),
                                    textAlign: TextAlign.center,
                                    style: Styles.style16700.copyWith(fontWeight: FontWeight.w500, color: AppColors.white, fontFamily: 'Tajawal'),
                                  ),
                                ],
                              ),
                              onPress: () {
                                if (indexPage != 3) {
                                  pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.linear);
                                } else {
                                  context.navigateToPageWithReplacement(const FinishOnBoardingScreen());
                                }
                              },
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

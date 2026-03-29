import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/app_icons.dart';
import 'package:matlop_provider/feature/bottomNavBarScreen/presentation/widgets/whats_app_button.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int selectedIconIndex;
  final Function(int) onIconTapped;
  final List<Widget> screenList;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIconIndex,
    required this.onIconTapped,
    required this.screenList,
  });

  @override
  CustomBottomNavBarState createState() => CustomBottomNavBarState();
}

class CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: 90.h,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Positioned.fill(
                  child: SvgPicture.asset(
                    AppIcons.navbar,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10.h),
                  color: Colors.transparent,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final double screenWidth = constraints.maxWidth;
                      final double selectedIconPosition = _getSelectedIconPosition(
                        widget.selectedIconIndex,
                        screenWidth,
                      );

                      return Stack(
                        children: [
                          AnimatedPositioned(
                            left: context.locale.languageCode == 'ar' ? selectedIconPosition : null,
                            right: context.locale.languageCode == 'en' ? selectedIconPosition : null,
                            top: 0,
                            bottom: 0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            child: Container(
                              padding: const EdgeInsets.all(23.5),
                              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                              width: 50, // Set a width
                              height: 50, // Set a height
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildSelectableIcon(0, AppIcons.unSelectedHome),
                              _buildSelectableIcon(1, AppIcons.unSelectedCopy),
                              const SizedBox(width: 65),
                              _buildSelectableIcon(2, AppIcons.unSelectedItem),
                              _buildSelectableIcon(3, AppIcons.unSelectedMenu),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            top: -27,
            child: WhatsAppButton(),
          ),
        ],
      ),
    );
  }

  // Function to return dynamic position based on screen width
  double _getSelectedIconPosition(int index, double screenWidth) {
    double iconPositionFactor;

    switch (index) {
      case 0:
        iconPositionFactor = 0.8223;
        break;
      case 1:
        iconPositionFactor = 0.645;
        break;
      case 2:
        iconPositionFactor = 0.24;
        break;
      case 3:
        iconPositionFactor = 0.058;
        break;
      default:
        iconPositionFactor = 0.0;
        break;
    }

    return screenWidth * iconPositionFactor;
  }

  Widget _buildSelectableIcon(int index, String iconPath) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: () {
        widget.onIconTapped(index);
      },
      child: Center(
        child: SizedBox(
          height: 30,
          width: 50,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: SvgPicture.asset(
              index == widget.selectedIconIndex ? selectedIconIndex[index] : iconPath,
              height: 30,
              width: 50,
              colorFilter: ColorFilter.mode(
                widget.selectedIconIndex == index ? AppColors.primaryColor : Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<String> selectedIconIndex = [
  AppIcons.selectedHOme,
  AppIcons.selectedOrder,
  AppIcons.selectedChat,
  AppIcons.selectedMenu,
];

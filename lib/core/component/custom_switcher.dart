import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/themes/colors.dart';

class CustomSwitcher extends StatelessWidget {
  final int selectedIndex;
  final double pageOffset;
  final Function(int) onSwitcherTapped;

  const CustomSwitcher({
    super.key,
    required this.selectedIndex,
    required this.pageOffset,
    required this.onSwitcherTapped,
  });

  double getAnimationWidth(BuildContext context, double pageOffset) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double segmentWidth = screenWidth * 0.42;
    final double spacing = screenWidth * 0.02;

    return (spacing + segmentWidth) * pageOffset;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14), //32
      padding: const EdgeInsets.all(10), //20
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastLinearToSlowEaseIn,
            left: context.locale.languageCode == 'en' ? getAnimationWidth(context, pageOffset) : null,
            right: context.locale.languageCode == 'en' ? null : getAnimationWidth(context, pageOffset),
            top: 0,
            bottom: 0,
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: AppColors.primaryColor,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              2,
              (index) {
                return InkWell(
                  overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                  onTap: () {
                    onSwitcherTapped(index);
                  },
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.all(10),
                    width: (MediaQuery.sizeOf(context).width - 54) / 2,
                    child: Center(
                      child: Text(
                        index == 0 ? 'Order'.tr() : 'Special Order'.tr(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: selectedIndex == index ? Colors.white : Colors.grey,
                            ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

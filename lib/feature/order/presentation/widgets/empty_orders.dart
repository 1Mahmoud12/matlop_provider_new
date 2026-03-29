import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/app_images.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/feature/bottomNavBarScreen/bottom_nav_bar_view.dart';

class EmptyOrders extends StatelessWidget {
  const EmptyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 150,
              width: 150,
              child: Image.asset(
                AppImages.thereIsNoOrders,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              'There is no order until now'.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Explore the available services on the homepage and choose what suits you to easily create a new request'.tr(),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.textColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            // CustomTextButton(
            //   borderRadius: 12,
            //   onPress: () {
            //     context.navigateToPageWithClearStack(const BottomNavBarView());
            //   },
            //   child: Text(
            //     'Discover services'.tr(),
            //     style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

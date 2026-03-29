import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/app_images.dart';

class EmptyData extends StatelessWidget {
  final String? title;
  final bool showImage;
  const EmptyData({super.key,  this.title, this.showImage=true});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if(showImage)
          SizedBox(
            height: 180,

            child: Image.asset(
              AppImages.thereIsNoOrders,
              fit: BoxFit.cover,
            ),
          ),const SizedBox(height: 10,),
          Text(
              title?? 'There is no data until now'.tr(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Explore the another section until add new data'.tr(),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.textColor,  fontSize: 15,
              fontWeight: FontWeight.w500,),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 80,
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
    );
  }
}

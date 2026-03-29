import 'package:easy_localization/easy_localization.dart'; // Add this import for localization
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/component/cache_image.dart';
import 'package:matlop_provider/core/component/notification_icon.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/feature/menu/views/editProfile/presentation/edit_profile_view.dart';

class HomeViewHeader extends StatelessWidget {
  const HomeViewHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(40),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  context.navigateToPage(const EditProfileView());
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CacheImage(
                      imageUrl: userCacheValue?.data?.imgSrc ?? '',
                      width: 35,
                      height: 35,
                      circle: true,
                      profileImage: true,
                      previewImage: false,
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => context.navigateToPage(const EditProfileView()),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back,'.tr(), // Changed to English key
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            userCacheValue?.data?.name ?? Constants.unKnownValue, // Changed to English key
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const NotificationIcon(),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          // GestureDetector(
          //   onTap: () {
          //     context.navigateToPage(
          //       BlocProvider(
          //         create: (context) => AddNewAddressCubit(),
          //         child: const AddNewAddressView(),
          //       ),
          //     );
          //   },
          //   child: CustomTextFormField(
          //     controller: TextEditingController(),
          //     hintText: 'Enter your location....'.tr(),
          //     outPadding: EdgeInsets.zero,
          //     borderRadius: 35.r,
          //     enable: false,
          //     suffixIcon: Padding(
          //       padding: const EdgeInsets.all(12),
          //       child: SvgPicture.asset(AppIcons.routing),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/component/cache_image.dart';
import 'package:matlop_provider/core/component/notification_icon.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/feature/menu/views/editProfile/presentation/edit_profile_view.dart';

class HomeViewHeader extends StatefulWidget {
  const HomeViewHeader({super.key});

  @override
  State<HomeViewHeader> createState() => _HomeViewHeaderState();
}

class _HomeViewHeaderState extends State<HomeViewHeader> {
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
                onTap: () async {
                  await context.navigateToPage(const EditProfileView());
                  if (mounted) setState(() {});
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Use profileCacheValue imgSrc directly — it's already the clean, trimmed full URL.
                    // Key forces CacheImage to rebuild when the URL changes after a profile update.
                    Builder(builder: (context) {
                      final imgUrl = profileCacheValue?.data?.imgSrc?.trim() ?? '';
                      return CacheImage(
                        key: ValueKey(imgUrl),
                        imageUrl: imgUrl,
                        width: 35,
                        height: 35,
                        circle: true,
                        profileImage: true,
                        previewImage: false,
                      );
                    }),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () async {
                        await context.navigateToPage(const EditProfileView());
                        if (mounted) setState(() {});
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back,'.tr(),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            // Show firstName + lastName from profileCacheValue (freshest source)
                            // Fall back to userCacheValue name if profile hasn't loaded yet
                            () {
                              final fName = profileCacheValue?.data?.firstName ?? '';
                              final lName = profileCacheValue?.data?.lastName ?? '';
                              return fName.isNotEmpty || lName.isNotEmpty
                                  ? '$fName $lName'.trim()
                                  : userCacheValue?.data?.name ?? Constants.unKnownValue;
                            }(),
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

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matlop_provider/core/component/cache_image.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/app_icons.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/feature/menu/views/editProfile/presentation/edit_profile_view.dart';

class MenuHeader extends StatefulWidget {
  const MenuHeader({
    super.key,
  });

  @override
  State<MenuHeader> createState() => _MenuHeaderState();
}

class _MenuHeaderState extends State<MenuHeader> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await context.navigateToPage(const EditProfileView());
        if (mounted) setState(() {});
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Builder(builder: (context) {
            final profileImg = profileCacheValue?.data?.imgSrc?.trim();
            final userImg = userCacheValue?.data?.profile?.imgSrc?.trim();
            final imgUrl = (profileImg != null && profileImg.isNotEmpty) ? profileImg : (userImg ?? '');
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello Again,'.tr(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                userCacheValue?.data?.name??'',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey.withOpacity(0.7)),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () async {
              await context.navigateToPage(const EditProfileView());
              if (mounted) setState(() {});
            },
            child: SvgPicture.asset(AppIcons.editIcon),
          ),
        ],
      ),
    );
  }
}

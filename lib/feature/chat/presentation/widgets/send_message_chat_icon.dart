import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/app_icons.dart';
import 'package:matlop_provider/core/utils/extensions.dart';

class SendMessageChatIcon extends StatelessWidget {
  const SendMessageChatIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10).w,
      decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(10.r)),
      child: context.locale.languageCode == 'en'
          ? SvgPicture.asset(
              AppIcons.sendIcon,
              colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
              width: context.screenWidth * .07,
            )
          : Transform.rotate(
              angle: -pi / 2,
              child: SvgPicture.asset(
                AppIcons.sendIcon,
                colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                width: context.screenWidth * .07,
              ),
            ),
    );
  }
}

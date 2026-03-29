import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/app_icons.dart';
import 'package:matlop_provider/feature/menu/presentation/manager/cubit/menu_cubit.dart';

class WhatsAppButton extends StatelessWidget {
  const WhatsAppButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MenuCubit.of(context).whatsapp();
      },
      child: Container(
        padding: const EdgeInsets.all(13),
        height: 54,
        width: 54,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              offset: const Offset(0, 4),
              color: AppColors.primaryColor.withOpacity(0.7),
            ),
          ],
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Color(0xff20D4AD), Color(0xff06B396)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            //  stops: [0.1, 1],
          ),
        ),
        child: SvgPicture.asset(AppIcons.whatsAppIcon),
      ),
    );
  }
}

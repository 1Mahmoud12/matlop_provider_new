import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/component/buttons/arrow_back_button.dart';
import 'package:matlop_provider/core/themes/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? widget;
  final bool showArrow;

  const CustomAppBar({super.key, required this.title, this.widget, this.showArrow=true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.transparent,
      elevation: 0,
      flexibleSpace: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        child: Container(
          color: AppColors.primaryColor,
          child: Row(
            children: [
              if (showArrow)
              const ArrowBackButton(
                borderColor: Colors.white,
                iconColor: Colors.white,
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(width: 10),
              Center(
                child: Text(
                  title.tr(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                ),
              ),
              const Spacer(),
              if (widget != null) widget!,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(75);
}

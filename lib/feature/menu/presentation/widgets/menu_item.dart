import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matlop_provider/core/themes/colors.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.icon,
    required this.text,
    this.color,
    required this.onTap,
    this.suffixWidget,
  });

  final String icon;
  final String text;
  final Color? color;
  final VoidCallback onTap;
  final Widget? suffixWidget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Material(
        color: Colors.transparent, // Ensures InkWell displays ripple effect
        child: Container(
          height: 70,
          width: double.infinity, // Use the full width of the screen
          padding: EdgeInsets.only(
            bottom: 10,
            right: context.locale.languageCode == 'ar' ? 0 : 10,
            left: context.locale.languageCode == 'ar' ? 10 : 0,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color ?? AppColors.primaryColor.withOpacity(0.15),
                ),
                child: SvgPicture.asset(icon),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              if (suffixWidget != null) suffixWidget!,
            ],
          ),
        ),
      ),
    );
  }
}

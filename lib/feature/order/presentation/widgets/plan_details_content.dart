import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matlop_provider/core/themes/colors.dart';

class PlanDetailsContent extends StatelessWidget {
  const PlanDetailsContent({
    super.key,
    required this.icon,
    required this.text,
    required this.value,
  });

  final String icon;
  final String text;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textColor, fontSize: 14.sp),
        ),
        // const Spacer(),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16.sp),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

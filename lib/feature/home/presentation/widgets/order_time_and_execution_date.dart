import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matlop_provider/core/themes/colors.dart';

class OrderTimeAndExecutionDate extends StatelessWidget {
  const OrderTimeAndExecutionDate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Order Time: ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: 'From 01:00 PM to 5:00 PM',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 10.sp,
                        color: AppColors.textColor,
                      ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Order Execution Date: ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                WidgetSpan(
                  child: Text(
                    '16 December 2024',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 10.sp,
                          color: AppColors.textColor,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

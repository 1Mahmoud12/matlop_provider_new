import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matlop_provider/core/component/custom_divider_widget.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/app_icons.dart';
import 'package:matlop_provider/feature/order/data/models/get_order_details_model.dart';
import 'package:matlop_provider/feature/order/presentation/widgets/plan_details_content.dart';

class OrderSchedulesListWidget extends StatelessWidget {
  final List<OrderSchedule> schedules;

  const OrderSchedulesListWidget({super.key, required this.schedules});

  String _formatDate(String dateTimeString) {
    if (dateTimeString.isEmpty) return '';
    try {
      final DateTime parsedDateTime = DateTime.parse(dateTimeString);
      final String day = parsedDateTime.day.toString().padLeft(2, '0');
      final String month = parsedDateTime.month.toString().padLeft(2, '0');
      final String year = parsedDateTime.year.toString();

      int hour = parsedDateTime.hour;
      final int minute = parsedDateTime.minute;
      final String period = hour >= 12 ? 'PM' : 'AM';
      hour = hour > 12 ? hour - 12 : hour;
      if (hour == 0) hour = 12;

      return '$day/$month/$year $hour:${minute.toString().padLeft(2, '0')} $period';
    } catch (_) {
      return dateTimeString;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (schedules.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row(
          //   children: [
          //     Icon(Icons.calendar_month_outlined, color: AppColors.primaryColor, size: 24.sp),
          //     SizedBox(width: 8.w),
          //     Text(
          //       'Visits Schedule'.tr(),
          //       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          //             color: AppColors.textColor,
          //             fontWeight: FontWeight.bold,
          //           ),
          //     ),
          //   ],
          // ),
          const SizedBox(height: 10),
          ...schedules.asMap().entries.map((entry) {
            final index = entry.key;
            final schedule = entry.value;
            final bool isLast = index == schedules.length - 1;

            return Column(
              children: [
                PlanDetailsContent(
                  icon: AppIcons.calendar,
                  text: '${'Visit'.tr()} ${index + 1}:',
                  value: _formatDate(schedule.visitDate ?? ''),
                ),
                if (!isLast) const CustomDividerWidget(),
              ],
            );
          }),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/app_icons.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/feature/order/data/models/order_model.dart';
import 'package:matlop_provider/feature/order/presentation/widgets/order_details_view.dart';

class OrderCardWithStatus extends StatefulWidget {
  final OrderData orderData;

  const OrderCardWithStatus({
    super.key,
    required this.orderData,
  });

  @override
  State<OrderCardWithStatus> createState() => _OrderCardWithStatusState();
}

class _OrderCardWithStatusState extends State<OrderCardWithStatus> {
  @override
  initState() {
    extractFormattedDateAndTime(widget.orderData.nextVistDate ?? '');
    super.initState();
  }

  String formattedDate = '';
  String formattedTime = '';

  String extractFormattedDateAndTime(String dateTimeString) {
    // Parse the date-time string to a DateTime object
    final DateTime parsedDateTime = DateTime.parse(dateTimeString);

    // Extract the components from the parsed DateTime
    final String day = parsedDateTime.day.toString().padLeft(2, '0');
    final String month = parsedDateTime.month.toString().padLeft(2, '0');
    final String year = parsedDateTime.year.toString();

    // Format the date as "day/month/year"
    formattedDate = '$day/$month/$year';

    // Format the time in 12-hour format with AM/PM
    int hour = parsedDateTime.hour;
    final int minute = parsedDateTime.minute;
    final String period = hour >= 12 ? 'PM' : 'AM';
    hour = hour > 12 ? hour - 12 : hour; // Convert to 12-hour format
    if (hour == 0) hour = 12; // Handle midnight as 12 AM

    formattedTime = "$hour:${minute.toString().padLeft(2, '0')} $period";

    // Return the formatted date and time
    return '$formattedDate $formattedTime';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.navigateToPage(
          OrderDetailsView(
            orderData: widget.orderData.orderId ?? 0,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${widget.orderData.package?.price} ${'SAR'.tr()} ',
                  // '200 ${'SAR'.tr()} ',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'Including Tax'.tr(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.primaryColor),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    color: widget.orderData.orderStatusEnum == 8
                        ? const Color(0xffDC1E1E)
                        : widget.orderData.orderStatusEnum == 7
                            ? const Color(0xff5DA945)
                            : const Color(0xffEF900A),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    widget.orderData.orderStatusEnum == 8
                        ? 'Cancelled'.tr()
                        : widget.orderData.orderStatusEnum == 7
                            ? 'Completed'.tr()
                            : 'In Progress'.tr(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${widget.orderData.packageName}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 0.5,
              color: AppColors.primaryColor.withOpacity(0.2),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SvgPicture.asset(AppIcons.visits),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Number of Visits'.tr(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.withOpacity(0.8)),
                ),
                Text(
                  ' ${widget.orderData.package?.visitNumber}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Spacer(),
                SvgPicture.asset(AppIcons.clock),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Number of Hours'.tr(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.withOpacity(0.8)),
                ),
                Text(
                  ' ${widget.orderData.package?.visitHours!.toInt()}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 0.5,
              color: AppColors.primaryColor.withOpacity(0.2),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SvgPicture.asset(AppIcons.calendar),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    ' $formattedDate',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.withOpacity(0.8)),
                  ),
                ),
                const Spacer(),
                SvgPicture.asset(AppIcons.clock),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    ' $formattedTime',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.withOpacity(0.8)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

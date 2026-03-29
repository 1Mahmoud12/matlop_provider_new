import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/component/custom_divider_widget.dart';
import 'package:matlop_provider/core/utils/app_icons.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/order/data/models/get_order_details_model.dart';
import 'package:matlop_provider/feature/order/presentation/widgets/plan_details_content.dart';

class PlanDetailsOrderDetails extends StatefulWidget {
  final OrderDetailsData orderData;

  const PlanDetailsOrderDetails({super.key, required this.orderData});

  @override
  State<PlanDetailsOrderDetails> createState() => _PlanDetailsOrderDetailsState();
}

class _PlanDetailsOrderDetailsState extends State<PlanDetailsOrderDetails> {
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          PlanDetailsContent(
            icon: AppIcons.orderNumber,
            text: 'Order Number:'.tr(),
            value: '${widget.orderData.orderId}',
          ),
          const CustomDividerWidget(),
          PlanDetailsContent(
            icon: AppIcons.clientName,
            text: 'client name:'.tr(),
            value: '${widget.orderData.clientName}',
          ),
          const CustomDividerWidget(),
          PlanDetailsContent(
            icon: AppIcons.visitNumber,
            text: 'Visits number:'.tr(),
            value: '${widget.orderData.package?.visitNumber}',
          ),
          const CustomDividerWidget(),
          PlanDetailsContent(
            icon: AppIcons.clientLocation,
            text: 'Client location:'.tr(),
            value: '${widget.orderData.locationName}',
          ),
          const CustomDividerWidget(),
          PlanDetailsContent(
            icon: AppIcons.mainSection,
            text: 'Package price:'.tr(),
            value: '${Utils.convertNumberToArabic(widget.orderData.package?.price?.toString() ?? '')} ${'SAR'.tr()}',
          ),
          const CustomDividerWidget(),
          PlanDetailsContent(
            icon: AppIcons.calendar,
            text: 'Order Date:'.tr(),
            value: formattedDate,
          ),
          const CustomDividerWidget(),
          PlanDetailsContent(
            icon: AppIcons.clock,
            text: 'Order Time:'.tr(),
            value: formattedTime,
          ),
          const CustomDividerWidget(),
          PlanDetailsContent(
            icon: AppIcons.card,
            text: 'Payment way:'.tr(),
            value: '${widget.orderData.paymentWayName}',
          ),
          // const CustomDividerWidget(),
          // CoponeDetails(itemSpecialOrdersModel: package),
        ],
      ),
    );
  }
}

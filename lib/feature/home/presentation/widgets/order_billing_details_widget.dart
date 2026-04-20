import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/component/custom_divider_widget.dart';
import 'package:matlop_provider/core/utils/app_icons.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/order/data/models/get_order_details_model.dart';
import 'package:matlop_provider/feature/order/presentation/widgets/plan_details_content.dart';

class OrderBillingDetailsWidget extends StatelessWidget {
  final OrderDetailsData orderData;

  const OrderBillingDetailsWidget({super.key, required this.orderData});

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
            icon: AppIcons.mainSection,
            text: 'Subtotal:'.tr(),
            value: '${Utils.convertNumberToArabic(orderData.orderSubTotal?.toString() ?? '0')} ${'SAR'.tr()}',
          ),
          if ((orderData.taxAmount ?? 0) > 0) ...[
            const CustomDividerWidget(),
            PlanDetailsContent(
              icon: AppIcons.mainSection,
              text: '${'Tax'.tr()} (${Utils.convertNumberToArabic(orderData.taxPercentageSnapshot?.toString() ?? '0')}%):',
              value: '${Utils.convertNumberToArabic(orderData.taxAmount?.toString() ?? '0')} ${'SAR'.tr()}',
            ),
          ],
          const CustomDividerWidget(),
          PlanDetailsContent(
            icon: AppIcons.card,
            text: 'Order Total:'.tr(),
            value: '${Utils.convertNumberToArabic(orderData.orderTotal?.toString() ?? '0')} ${'SAR'.tr()}',
          ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/component/custom_divider_widget.dart';
import 'package:matlop_provider/core/utils/app_icons.dart';
import 'package:matlop_provider/feature/order/data/models/details_special_order_model.dart';
import 'package:matlop_provider/feature/order/presentation/widgets/plan_details_content.dart';

class SpecialOrderPlanDetails extends StatelessWidget {
  final DetailsSpecialOrderModel detailsSpecialOrderModel;

  const SpecialOrderPlanDetails({super.key, required this.detailsSpecialOrderModel});

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
            value: detailsSpecialOrderModel.data!.specialOrderId.toString(),
          ),
          const CustomDividerWidget(),
          PlanDetailsContent(
            icon: AppIcons.clientName,
            text: 'client name:'.tr(),
            value: detailsSpecialOrderModel.data!.clientName.toString(),
          ),
          // const CustomDividerWidget(),
          // PlanDetailsContent(
          //   icon: AppIcons.clock,
          //   text: 'Order Time:'.tr(),
          //   value: 'details',
          // ),
          const CustomDividerWidget(),
          PlanDetailsContent(
            icon: AppIcons.clock,
            text: 'Price: '.tr(),
            value: '${detailsSpecialOrderModel.data!.amount?? 0} ${'SAR'.tr()}',
          ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/feature/order/data/models/special_orders_model.dart';

class PriceAndOrderDescription extends StatelessWidget {
  final ItemSpecialOrder itemSpecialOrder;

  const PriceAndOrderDescription({
    super.key,
    required this.itemSpecialOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '#${itemSpecialOrder.specialOrderId ?? Constants.unKnownValue}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            // const SizedBox(
            //   width: 3,
            // ),
            // Text(
            //   '${itemSpecialOrder.specialOrderId??Constants.unKnownValue}',
            //   style: Theme.of(context).textTheme.bodySmall!.copyWith(
            //         color: AppColors.textColor,
            //       ),
            // )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Order Description'.tr(),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.black,
              ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          itemSpecialOrder.notes ?? Constants.unKnownValue,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.textColor,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}

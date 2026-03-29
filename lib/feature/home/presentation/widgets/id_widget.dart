import 'package:flutter/material.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/feature/order/data/models/order_model.dart';

class IDWidget extends StatelessWidget {
  const IDWidget({
    super.key,
    required this.orderData,
  });

  final OrderData orderData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'ID: ${orderData.orderId}',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.primaryColor,
            ),
      ),
    );
  }
}

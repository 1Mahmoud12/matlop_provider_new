import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matlop_provider/core/utils/app_icons.dart';
import 'package:matlop_provider/feature/order/data/models/order_model.dart';

class NameAndLocationData extends StatelessWidget {
  const NameAndLocationData({
    super.key,
    required this.orderData,
  });
  final OrderData orderData;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${orderData.package?.nameEn}",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            SvgPicture.asset(
              AppIcons.routing,
              height: 20,
              width: 20,
            ),
            Text('Location: ${orderData.locationName}'),
          ],
        ),
      ],
    );
  }
}

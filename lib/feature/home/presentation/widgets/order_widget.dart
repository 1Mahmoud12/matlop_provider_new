import 'package:flutter/material.dart';
import 'package:matlop_provider/core/component/custom_divider_widget.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/feature/home/presentation/widgets/id_widget.dart';
import 'package:matlop_provider/feature/home/presentation/widgets/name_and_location_data.dart';
import 'package:matlop_provider/feature/home/presentation/widgets/order_time_and_execution_date.dart';
import 'package:matlop_provider/feature/home/presentation/widgets/profile_image.dart';
import 'package:matlop_provider/feature/order/data/models/order_model.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key, required this.orderData});
  final OrderData orderData;

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // context.navigateToPage(
        //   const OrderDetailsView(
        //       // orderData: widget.orderData,
        //       ),
        // );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey[200]!,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const ProfileImage(),
                const SizedBox(width: 8),
                NameAndLocationData(
                  orderData: widget.orderData,
                ),
                const Spacer(),
                IDWidget(
                  orderData: widget.orderData,
                ),
              ],
            ),
            const SizedBox(height: 8),
            const CustomDividerWidget(),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildChip("${widget.orderData.packageName}", context),
                const SizedBox(
                  width: 5,
                ),
                _buildChip("${widget.orderData.package?.nameEn}", context),
                const SizedBox(
                  width: 5,
                ),
                _buildChip("${widget.orderData.package?.visitNumber}", context),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Divider(
              thickness: 0.5,
              color: AppColors.primaryColor.withOpacity(0.15),
            ),
            const SizedBox(height: 8),
            const OrderTimeAndExecutionDate()
          ],
        ),
      ),
    );
  }

  // Helper method to build the order details chip
  Widget _buildChip(String label, BuildContext context) {
    return Expanded(
      child: Container(
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey[200]!,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            )),
      ),
    );
  }
}

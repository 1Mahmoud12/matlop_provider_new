import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/feature/order/presentation/manager/cubit/order_cubit.dart';
import 'package:matlop_provider/feature/order/presentation/widgets/filter_selection_button.dart';

class FilterOrderDialog extends StatefulWidget {
  const FilterOrderDialog({super.key, required this.selectedStatus, required this.onStatusChanged});
  final String selectedStatus;
  final Function(String) onStatusChanged;

  @override
  State<FilterOrderDialog> createState() => _FilterOrderDialogState();
}

class _FilterOrderDialogState extends State<FilterOrderDialog> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Filter by Status'.tr(), style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 20),
            Column(
              children: List.generate(Constants.selectedStatus.length, (index) {
                return FilterSelectedButton(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  selectedIndex: _selectedIndex,
                  index: index,
                  selectedStatus: Constants.selectedStatus[index],
                );
              }),
            ),
            CustomTextButton(
              borderRadius: 16,
              child: Text('Show'.tr(), style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white)),
              onPress: () {
                if (_selectedIndex == 0) {
                  OrderCubit.of(context).getOrderByStatus(context, status: 0);
                } else if (_selectedIndex == 1) {
                  OrderCubit.of(context).getOrderByStatus(context, status: 7);
                } else {
                  OrderCubit.of(context).getOrderByStatus(context, status: 8);
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

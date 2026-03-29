import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/feature/order/presentation/widgets/filter_selection_button.dart';

class FilterSpecialOrderDialog extends StatefulWidget {
  final String selectedOrderType;
  final String selectedStatus;
  final  Function(int status,int type)? onPress;

  const FilterSpecialOrderDialog({
    super.key,
    required this.selectedOrderType,
    required this.selectedStatus, this.onPress,
  });

  @override
  FilterSpecialOrderDialogState createState() => FilterSpecialOrderDialogState();
}

class FilterSpecialOrderDialogState extends State<FilterSpecialOrderDialog> {
  String? _selectedOrderType;
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedOrderType = widget.selectedOrderType;
    _selectedStatus = widget.selectedStatus;
  }

  int _selectedOrderTypeIndex = 0;
  int _selectedOrderStatusIndex = 0;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title:  Text('Order Type'.tr()),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text('Select Order Type:'.tr()),
            const SizedBox(height: 10),
            Column(
              children: List.generate(Constants.orderType.length, (index) {
                return FilterSelectedButton(
                  onTap: () {
                    setState(() {
                      _selectedOrderTypeIndex = index;
                    });
                  },
                  selectedIndex: _selectedOrderTypeIndex,
                  index: index,
                  selectedStatus: Constants.orderType[index],
                );
              }),
            ),
            const SizedBox(height: 20),
             Text('Select Status:'.tr()),
            const SizedBox(height: 10),
            Column(
              children: List.generate(Constants.selectedStatus.length, (index) {
                return FilterSelectedButton(
                  onTap: () {
                    setState(() {
                      _selectedOrderStatusIndex = index;
                    });
                  },
                  selectedIndex: _selectedOrderStatusIndex,
                  index: index,
                  selectedStatus: Constants.selectedStatus[index],
                );
              }),
            )
          ],
        ),
      ),
      actions: [
        CustomTextButton(
          borderRadius: 16,
          child: Text('Show'.tr(), style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white)),
          onPress: () {
            Navigator.pop(context);
            widget.onPress?.call(_selectedOrderStatusIndex,_selectedOrderTypeIndex);
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:matlop_provider/core/themes/colors.dart';

class FilterSelectedButton extends StatelessWidget {
  const FilterSelectedButton({super.key, required this.selectedStatus, required this.index, required this.selectedIndex, required this.onTap});

  final String selectedStatus;
  final int index, selectedIndex;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryColor.withOpacity(0.4)),
              ),
              child: Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(shape: BoxShape.circle, color: selectedIndex == index ? AppColors.primaryColor : Colors.white),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(selectedStatus, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

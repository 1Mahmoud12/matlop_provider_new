import 'package:matlop_provider/core/themes/colors.dart';
import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  final Color selectedColor;

  const DotIndicator({
    super.key,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 8,
      height: 8,
      decoration: ShapeDecoration(
        color: selectedColor.withOpacity(selectedColor == AppColors.textColor ? 1 : .3),
        shape: const OvalBorder(),
      ),
    );
  }
}

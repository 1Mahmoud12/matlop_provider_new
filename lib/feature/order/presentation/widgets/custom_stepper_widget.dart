import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/app_icons.dart';
import 'package:matlop_provider/core/utils/constants_enum.dart';

class CustomStepper extends StatefulWidget {
  final int selectedStatus;

  const CustomStepper({super.key, required this.selectedStatus});

  @override
  CustomStepperState createState() => CustomStepperState();
}

class CustomStepperState extends State<CustomStepper> {
  int _currentStep = -1; // Start with no active step.
  final int _totalSteps = OrderStatusEnum.values.length;

  @override
  void initState() {
    super.initState();
    log('new status in stepper ${widget.selectedStatus}');
    _currentStep = widget.selectedStatus;
  }

  @override
  Widget build(BuildContext context) {
    _currentStep = widget.selectedStatus;

    return SizedBox(
      height: 110, // Increased height to accommodate text labels
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double stepWidth = (constraints.maxWidth / (_totalSteps - 1)) - 10;
          return Stack(
            alignment: Alignment.centerLeft,
            children: [
              // Inactive Line
              Positioned(
                top: 15, // Center vertically based on circle size
                left: 30, // Padding from the first circle
                right: 30, // Padding from the last circle
                child: Container(
                  height: 3,
                  color: AppColors.primaryColor.withOpacity(0.2),
                ),
              ),
              // Active Line
              Positioned(
                top: 15,
                left: 30,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 3,
                  width: _currentStep >= 0 ? stepWidth * _currentStep : 0, // Adjust width based on current step
                  color: AppColors.primaryColor,
                ),
              ),
              // Step Circles and Labels
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_totalSteps, (index) {
                  return Expanded(child: buildStep(index, stepWidth));
                }),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildStep(int index, double stepWidth) {
    final bool isActive = _currentStep >= index;
    return GestureDetector(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Circle
          Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                AppIcons.stepperShape,
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                  isActive ? AppColors.primaryColor : AppColors.cDisablePrimaryColor,
                  BlendMode.srcIn,
                ),
                width: 30,
                height: 30,
              ),
              Text(
                (index).toString(),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Label
          Expanded(
            child: Text(
              OrderStatusEnum.values[index].name.tr(),
              textAlign: TextAlign.center,
              maxLines: 2,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: isActive ? AppColors.fillColorTextFormField : AppColors.cFillColorDropDownButton,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matlop_provider/core/component/custom_drop_down_menu.dart';
import 'package:matlop_provider/core/themes/colors.dart';

class CalenderHeader extends StatelessWidget {
  const CalenderHeader({
    super.key,
    this.onTapArrowBack,
    this.onTapArrowForward,
    required this.currentDate,
    required this.onMonthYearSelected, // Add a callback for month/year selection
  });

  final void Function()? onTapArrowBack;
  final void Function()? onTapArrowForward;
  final DateTime currentDate;
  final Function(DateTime) onMonthYearSelected; // Callback to return the selected month/year

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          // Month and Year Picker
          GestureDetector(
            onTap: () async {
              final DateTime? picked = await showMonthYearDialog(context, currentDate);
              if (picked != null) {
                onMonthYearSelected(picked); // Update the parent widget with the selected date
              }
            },
            child: Text(
              DateFormat.yMMMM().format(currentDate), // Show the selected month/year in the header
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Spacer(),
          // Arrow Back Button
          GestureDetector(
            onTap: onTapArrowBack,
            child: SizedBox(
              height: 30,
              width: 30,
              child: Icon(
                Icons.arrow_back_ios_outlined,
                color: AppColors.cTextDate,
                size: 16.sp,
              ),
            ),
          ),
          const SizedBox(width: 30),
          // Arrow Forward Button
          GestureDetector(
            onTap: onTapArrowForward,
            child: SizedBox(
              height: 30,
              width: 30,
              child: Icon(
                Icons.arrow_forward_ios_outlined,
                color: AppColors.cTextDate,
                size: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<DateTime?> showMonthYearDialog(BuildContext context, DateTime currentDate) {
    int selectedMonth = currentDate.month;
    int selectedYear = currentDate.year;

    return showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.cDate,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text(
            'Select Month and Year'.tr(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          content: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Year Dropdown
                CustomDropDownMenu(
                  borderRadius: 12,
                  selectedItem: selectedYear.toString(),
                  listOfStingItems: List.generate(
                    50,
                    (index) {
                      final year = DateTime.now().year - 25 + index;
                      return year.toString();
                    },
                  ),
                  onChanged: (newYear) {
                    selectedYear = int.parse(newYear!);
                  },
                ),
                const SizedBox(height: 10),
                // Month Dropdown
                CustomDropDownMenu(
                  borderRadius: 12,
                  selectedItem: DateFormat.MMMM().format(DateTime(0, selectedMonth)),
                  listOfStingItems: List.generate(12, (index) {
                    return DateFormat.MMMM().format(DateTime(0, index + 1));
                  }),
                  onChanged: (newMonth) {
                    selectedMonth = DateFormat.MMMM().parse(newMonth!).month;
                  },
                ),
              ],
            ),
          ),
          actions: [
            // Cancel Button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close without changes
              },
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                side: BorderSide(color: Colors.grey.withOpacity(0.5)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                'Cancel'.tr(),
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            // Select Button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(DateTime(selectedYear, selectedMonth)); // Pass back the selected date
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                'Select'.tr(),
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }
}

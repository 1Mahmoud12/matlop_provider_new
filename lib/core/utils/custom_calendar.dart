import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/action_button_calender.dart';
import 'package:matlop_provider/core/utils/utils.dart';

import 'calender_header.dart';

class CustomCalendarWidget extends StatefulWidget {
  final DateTime initialDate;
  final Function(DateTime) onDateSelected;
  final List<DateTime>? holidaysList;
  final bool futureDay;
  final bool holiday;

  const CustomCalendarWidget({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
    this.holidaysList,
    this.futureDay = false,
    this.holiday = false,
  });

  @override
  CustomCalendarWidgetState createState() => CustomCalendarWidgetState();
}

class CustomCalendarWidgetState extends State<CustomCalendarWidget> {
  late DateTime currentDate;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    currentDate = widget.initialDate;
    selectedDate = widget.initialDate;
  }

  void _updateMonth(int months) {
    setState(() {
      final DateTime newDate = DateTime(currentDate.year, currentDate.month + months);

      // Prevent navigating to past months
      final DateTime now = DateTime.now();
      final DateTime firstDayOfCurrentMonth = DateTime(now.year, now.month);

      if (newDate.isBefore(firstDayOfCurrentMonth)) {
        return; // Don't update if the new date is in the past
      }

      currentDate = newDate;
      selectedDate = currentDate;
    });
  }

  List<DateTime> generateCalendarDays(DateTime monthStart) {
    final List<DateTime> calendarDays = [];
    final DateTime firstDayOfMonth = DateTime(monthStart.year, monthStart.month);
    final int adjustedStart = (firstDayOfMonth.weekday + 1) % 7;

    for (int i = adjustedStart; i > 0; i--) {
      calendarDays.add(firstDayOfMonth.subtract(Duration(days: i)));
    }

    final int daysInMonth = DateTime(monthStart.year, monthStart.month + 1, 0).day;
    for (int i = 0; i < daysInMonth; i++) {
      calendarDays.add(firstDayOfMonth.add(Duration(days: i)));
    }

    while (calendarDays.length < 35) {
      calendarDays.add(calendarDays.last.add(const Duration(days: 1)));
    }

    return calendarDays;
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    final DateTime firstDayOfMonth = DateTime(currentDate.year, currentDate.month);
    final List<DateTime> calendarDays = generateCalendarDays(firstDayOfMonth);

    return AspectRatio(
      aspectRatio: 0.9,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.cDate,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 0.56, color: AppColors.cBorderTextFormField),
        ),
        child: Column(
          children: [
            CalenderHeader(
              currentDate: currentDate,
              onTapArrowBack: () {
                _updateMonth(-1); // Navigate to the previous month
              },
              onTapArrowForward: () {
                _updateMonth(1); // Navigate to the next month
              },
              onMonthYearSelected: (selectedDate) {
                setState(() {
                  currentDate = selectedDate;
                });
              },
            ),
            const SizedBox(height: 15),
            Divider(
              thickness: 0.9,
              color: Colors.grey.withOpacity(0.3),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(7, (index) {
                  return Text(
                    DateFormat.E(context.locale == const Locale('ar', 'SA') ? 'ar_SA' : 'en_US').format(DateTime(2023, 1, index)),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.cTextDate,
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemCount: calendarDays.length,
                itemBuilder: (context, index) {
                  final DateTime date = calendarDays[index];
                  final bool isCurrentMonth = date.month == currentDate.month;

                  final bool isHoliday = widget.holidaysList?.any((holiday) => isSameDate(holiday, date)) ?? false;
// Check if the date is a Friday, Saturday, or in the past
                  final bool isPastDate = widget.futureDay ? date.isBefore(DateTime.now()) : false;
                  final bool isFridayOrSaturday = widget.holiday ? (date.weekday == DateTime.friday || date.weekday == DateTime.saturday) : false;

                  // Determine if the date should be disabled
                  final bool isDisabled = isPastDate || isFridayOrSaturday;

                  return GestureDetector(
                    onTap: isDisabled
                        ? () {
                      Utils.showToast(title: 'you must select future day and except friday and saturday', state: UtilState.warning);
                    }
                        : () {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: isDisabled
                            ? Colors.grey.withOpacity(.2)
                            : isSameDate(selectedDate, date)
                            ? AppColors.primaryColor
                            : AppColors.cDate,
                        gradient: isSameDate(selectedDate, date)
                            ? const LinearGradient(
                          colors: [
                            Color(0xff37EFC7),
                            Color(0xff33C0A8),
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        )
                            : null,
                        shape: BoxShape.circle,
                      ),
                      child: Column(
                        children: [
                          const Spacer(),
                          Center(
                            child: Text(
                              date.day.toString(),
                              style: TextStyle(
                                fontWeight: isCurrentMonth ? FontWeight.w500 : FontWeight.w300,
                                color: isSameDate(selectedDate, date) ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          if (isHoliday)
                            Container(
                              margin: const EdgeInsets.only(top: 4.0),
                              height: 5,
                              width: 5,
                              decoration: const BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ActionButtons(
              onConfirm: () {
                widget.onDateSelected(selectedDate);
                Navigator.pop(context);
              },
              onCancel: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

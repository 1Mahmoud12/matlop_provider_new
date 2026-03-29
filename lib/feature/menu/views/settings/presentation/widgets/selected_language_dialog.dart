import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/app_icons.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/feature/bottomNavBarScreen/bottom_nav_bar_view.dart';

class SelectLanguageDialog extends StatefulWidget {
  const SelectLanguageDialog({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  final int selectedIndex;

  @override
  State<SelectLanguageDialog> createState() => _SelectLanguageDialogState();
}

class _SelectLanguageDialogState extends State<SelectLanguageDialog> {
  int? selectedValue;

  @override
  void initState() {
    selectedValue = widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                'Language'.tr(),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Select your language'.tr(),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),

              // Arabic Option
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedValue = 0;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.4),
                    ),
                  ),
                  child: ListTile(
                    leading: SvgPicture.asset(
                      AppIcons.LangArabic,
                      width: 24,
                      height: 24,
                    ),
                    title: Text('Arabic'.tr()),
                    trailing: Radio<int>(
                      value: 0,
                      activeColor: AppColors.primaryColor,
                      groupValue: selectedValue,
                      onChanged: (int? value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const Divider(),

              // English Option
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedValue = 1;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.4),
                    ),
                  ),
                  child: ListTile(
                    leading: SvgPicture.asset(
                      AppIcons.LangEnglish,
                      width: 24,
                      height: 24,
                    ),
                    title: Text('English'.tr()),
                    trailing: Radio<int>(
                      value: 1,
                      activeColor: AppColors.primaryColor,
                      groupValue: selectedValue,
                      onChanged: (int? value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              CustomTextButton(
                borderRadius: 15,
                child: Text(
                  'Confirm'.tr(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                ),
                onPress: () {
                  setState(
                    () {
                      final Locale selectedLocale = (selectedValue == 0) ? const Locale('ar', 'SA') : const Locale('en', 'US');
                      context.setLocale(selectedLocale);
                      context.navigateToPageWithReplacement(const BottomNavBarView());
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

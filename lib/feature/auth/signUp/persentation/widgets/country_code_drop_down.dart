import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/app_icons.dart';

class CountryCodeDropdown extends StatelessWidget {
  final String selectedValue;
  final List<String> countryCodes;
  final ValueChanged<String?> onChanged;

  const CountryCodeDropdown({
    super.key,
    required this.selectedValue,
    required this.countryCodes,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      margin: const EdgeInsets.all(7),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor.withOpacity(0.2), width: 0.6), // Light border color
        borderRadius: BorderRadius.circular(30.0), // Rounded container
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedValue,
              icon: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: SvgPicture.asset(AppIcons.arrowDown),
              ),
              onChanged: onChanged,
              items: countryCodes.map<DropdownMenuItem<String>>((String code) {
                return DropdownMenuItem<String>(
                  value: code,
                  child: Text(
                    code,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

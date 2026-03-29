import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matlop_provider/core/utils/app_icons.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/feature/menu/views/editProfile/data/models/country_model.dart';

class CountryDropdown extends StatefulWidget {
  final Country? selectedCountry;
  final ValueChanged<Country?> onChanged;

  const CountryDropdown({
    super.key,
    required this.selectedCountry,
    required this.onChanged,
  });

  @override
  CountryDropdownState createState() => CountryDropdownState();
}

class CountryDropdownState extends State<CountryDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<Country>(
      dropdownColor: Colors.white,
      value: widget.selectedCountry,
      icon: Padding(
        padding: EdgeInsets.only(right: context.locale.languageCode == 'en' ? 8 : 0, left: context.locale.languageCode == 'ar' ? 8 : 0),
        child: SvgPicture.asset(AppIcons.arrowDown),
      ),
      underline: const SizedBox(),
      onChanged: widget.onChanged,
      items: Constants.countries.map<DropdownMenuItem<Country>>((Country country) {
        return DropdownMenuItem<Country>(
          value: country,
          child: Row(
            children: [
              Text(country.flag, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 8),
              Text(country.code, style: const TextStyle(fontSize: 16)),
            ],
          ),
        );
      }).toList(),
    );
  }
}

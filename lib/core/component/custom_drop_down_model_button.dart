import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/themes/colors.dart';

class DropDownModel extends Equatable {
  final String text;
  final int value;

  const DropDownModel(this.text, this.value);

  @override
  List<Object?> get props => [text, value];
}

class CustomDropdownWithModel extends StatefulWidget {
  const CustomDropdownWithModel({
    super.key,
    required this.text,
    required this.itemList,
    required this.textStyle,
    this.onItemSelected,
    this.nameFiled,
    this.value,
    this.errorText,
    this.showError = false,
  });

  final String text;
  final List<DropDownModel> itemList;
  final Function(DropDownModel)? onItemSelected;
  final TextStyle textStyle;
  final String? nameFiled;
  final String? value;
  final String? errorText;
  final bool showError;

  @override
  CustomDropdownWithModelState createState() => CustomDropdownWithModelState();
}

class CustomDropdownWithModelState extends State<CustomDropdownWithModel> {
  String? _selectedItemEvent;

  @override
  void initState() {
    _selectedItemEvent = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.nameFiled != null)
          Text(
            widget.nameFiled!,
            style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
          ),
        if (widget.nameFiled != null) const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12).copyWith(right: 20),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: AppColors.primaryColor.withOpacity(0.1),
              ),
              borderRadius: BorderRadius.circular(17),
            ),
          ),
          child: DropdownButton<DropDownModel>(
            borderRadius: BorderRadius.circular(10.0),
            dropdownColor: Colors.white,
            focusColor: Colors.white,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            isExpanded: true,
            iconSize: 30.0,
            elevation: 16,
            hint: Text((_selectedItemEvent ?? widget.text).tr(), style: widget.textStyle),
            underline: const SizedBox.shrink(),
            onChanged: (DropDownModel? newValue) {
              setState(() {
                _selectedItemEvent = newValue?.text;
              });
              if (widget.onItemSelected != null && newValue != null) {
                widget.onItemSelected!(newValue);
              }
            },
            items: widget.itemList.map((DropDownModel value) {
              return DropdownMenuItem<DropDownModel>(
                value: value,
                child: Text(value.text.tr()),
              );
            }).toList(),
          ),
        ),
        if (widget.showError && _selectedItemEvent == null && widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              widget.errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}

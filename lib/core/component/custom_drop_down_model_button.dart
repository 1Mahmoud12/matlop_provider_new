import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/component/cache_image.dart';

class DropDownModel extends Equatable {
  final String text;
  final int value;
  final String? image;

  const DropDownModel(this.text, this.value, {this.image});

  @override
  List<Object?> get props => [text, value, image];
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
    this.image,
  });

  final String text;
  final String? image;
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
  DropDownModel? _selectedItem;

  @override
  void initState() {
    if (widget.value != null) {
      try {
        _selectedItem = widget.itemList.firstWhere((element) => element.text == widget.value || element.value.toString() == widget.value);
      } catch (e) {
        // Not found
      }
    }
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
            value: _selectedItem,
            hint: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.image != null) ...[
                  CacheImage(
                    imageUrl: widget.image!,
                    width: 24,
                    height: 24,
                    profileImage: false,
                    previewImage: false,
                  ),
                  const SizedBox(width: 8),
                ],
                Text(widget.text.tr(), style: widget.textStyle, overflow: TextOverflow.ellipsis),
              ],
            ),
            selectedItemBuilder: (BuildContext context) {
              return widget.itemList.map((DropDownModel item) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (item.image != null) ...[
                      CacheImage(
                        imageUrl: item.image!,
                        width: 24,
                        height: 24,
                        profileImage: false,
                        previewImage: false,
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(item.text.tr(), style: widget.textStyle, overflow: TextOverflow.ellipsis),
                  ],
                );
              }).toList();
            },
            underline: const SizedBox.shrink(),
            onChanged: (DropDownModel? newValue) {
              setState(() {
                _selectedItem = newValue;
              });
              if (widget.onItemSelected != null && newValue != null) {
                widget.onItemSelected!(newValue);
              }
            },
            items: widget.itemList.map((DropDownModel value) {
              return DropdownMenuItem<DropDownModel>(
                value: value,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (value.image != null) ...[
                      CacheImage(
                        imageUrl: value.image!,
                        width: 24,
                        height: 24,
                        profileImage: false,
                        previewImage: false,
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(value.text.tr(), overflow: TextOverflow.ellipsis),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        if (widget.showError && _selectedItem == null && widget.errorText != null)
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

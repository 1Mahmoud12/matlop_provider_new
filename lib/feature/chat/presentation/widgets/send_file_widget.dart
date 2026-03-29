import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/themes/styles.dart';

class SendFileWidget extends StatelessWidget {
  const SendFileWidget({
    super.key,
    required this.fileName,
    required this.selectedFile,
    this.onCloseTap,
  });
  final String fileName;
  final File? selectedFile;
  final void Function()? onCloseTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

      //  height: 100,
      //width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Colors.grey.withOpacity(0.3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Stack(
            alignment: Alignment.center,
            children: [
              //  SvgPicture.asset(Assets.linkIcon),
              SizedBox(
                height: 35,
                width: 35,
                child: CircularProgressIndicator(
                  value: 0.25,
                  strokeWidth: 1.5,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 4,
            child: Text(
              fileName,
              style: Styles.style16500.copyWith(
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onCloseTap,
            child: const Icon(Icons.close_rounded),
          ),
        ],
      ),
    );
  }
}

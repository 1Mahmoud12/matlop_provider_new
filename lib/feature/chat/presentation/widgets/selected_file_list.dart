import 'dart:io';

import 'package:flutter/material.dart';
import 'package:matlop_provider/feature/chat/presentation/widgets/send_file_widget.dart';

class SelectedFileList extends StatelessWidget {
  const SelectedFileList({
    super.key,
    required this.selectedFile,
    required this.selectedImageName,
    this.onTapClose,
  });
  final File selectedFile;
  final String selectedImageName;
  final void Function()? onTapClose;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(
              1,
              (index) {
                return SendFileWidget(
                  selectedFile: selectedFile,
                  fileName: selectedImageName,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

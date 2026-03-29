import 'package:flutter/material.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/app_images.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 70,
        width: 70,
        child: Image.asset(AppImages.loadingIndicator),
      ),
    );
  }
}

void animationDialogLoading(
  BuildContext context, {
  void Function(bool, Object?)? onPopInvokedWithResult,
}) {
  showDialog(
    context: context,
    barrierColor: Colors.black26,
    barrierDismissible: false,
    builder: (context) => PopScope(
      onPopInvokedWithResult: onPopInvokedWithResult,
      child: Dialog(
        backgroundColor: AppColors.transparent,
        child: SizedBox(
          height: 50,
          width: 50,
          child: Image.asset(AppImages.loadingIndicator),
        ),
      ),
    ),
  );
}

void closeDialog(BuildContext context) {
  Navigator.pop(context);
}

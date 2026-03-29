import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/themes/colors.dart';

class AccountActionText extends StatelessWidget {
  const AccountActionText({
    super.key,
    required this.text1,
    required this.text2,
    required this.onTap,
  });
  final String text1;
  final String text2;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: text1,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: text2,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primaryColor,
                      decorationThickness: 2.0,
                    ),
                recognizer: TapGestureRecognizer()..onTap = onTap,
              ),
            ],
          ),
          textDirection: TextDirection.rtl,
        ),
        const Spacer(),
      ],
    );
  }
}

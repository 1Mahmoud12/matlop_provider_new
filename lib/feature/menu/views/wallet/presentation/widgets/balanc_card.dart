import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matlop_provider/core/utils/app_images.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    super.key,
    required this.balance,
  });

  final double balance;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              height: 180,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(context.locale.languageCode == 'ar' ? AppImages.backgroundBalance : AppImages.backgroundBalanceEnglish),
                  fit: BoxFit.cover,
                ),
                color: Colors.amber,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Your Balance'.tr(), // Added .tr() for localization
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        balance.toStringAsFixed(2),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontSize: 24.sp),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'SAR'.tr(), // Added .tr() for localization
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white.withOpacity(0.7)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/**
 *     image: DecorationImage(
    image: AssetImage(context.locale.languageCode == 'ar' ? AppImages.backgroundBalance : AppImages.backgroundBalanceEnglish),
    fit: BoxFit.cover),
    color: Colors.amber,
    borderRadius: BorderRadius.circular(20),
    ),
 */

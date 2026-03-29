import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matlop_provider/core/component/cache_image.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/app_icons.dart';
import 'package:matlop_provider/core/utils/constants_enum.dart';
import 'package:matlop_provider/feature/menu/views/wallet/data/model/transactions_model.dart';

class FinancialTransactionCard extends StatelessWidget {
  const FinancialTransactionCard({
    super.key,
    required this.withdraw,
  });

  final ItemTransaction withdraw;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 30,
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(0.1),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CacheImage(
            imageUrl: userCacheValue?.data?.imgSrc ?? '',
            width: 40,
            height: 40,
            circle: true,
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${'name'.tr()}: ',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  Text(
                    '${userCacheValue?.data?.name}',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors.cFillColorDropDownButton, fontWeight: FontWeight.w400, fontSize: 12.sp),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                DateFormat('dd/MMM/yyyy', context.locale.languageCode).format(DateTime.parse(withdraw.creationTime ?? DateTime.now().toString())),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.textColor.withOpacity(0.6),
                    ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    (withdraw.amount ?? 0).toInt().toString(),
                    style:
                        Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.cNewAmount, fontWeight: FontWeight.w700, fontSize: 16.sp),
                  ),
                  Text(
                    ' ${'SAR'.tr()}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.cNewAmount, fontWeight: FontWeight.w400, fontSize: 12.sp),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text(
                    withdraw.transactionType == TransactionTypeEnum.Deposit.name
                        ? TransactionTypeEnum.Deposit.name.tr()
                        : TransactionTypeEnum.Withdraw.name.tr(),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppColors.cSubTextColorTwo,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  SvgPicture.asset(
                    height: 18,
                    width: 18,
                    withdraw.transactionType == TransactionTypeEnum.Deposit.name ? AppIcons.depositIc : AppIcons.withdrawIc,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

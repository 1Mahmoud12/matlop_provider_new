import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/component/custom_app_bar.dart';
import 'package:matlop_provider/core/component/custom_text_form_field.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/app_images.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/utils/constants_enum.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/menu/views/wallet/presentation/manager/walletCubit/cubit/wallet_cubit.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        CustomTextButton(
          width: MediaQuery.sizeOf(context).width,
          borderRadius: 15,
          child: Text(
            'New transaction'.tr(),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
          ),
          onPress: () async {
            if (!formKey.currentState!.validate()) return;
            if (int.parse(WalletCubit.of(context).amountController.text) > (ConstantModel.walletModel?.data?.balance ?? 0).toInt()) {
              Utils.showToast(title: 'Your wallet balance is insufficient'.tr(), state: UtilState.warning);
            } else if (int.parse(WalletCubit.of(context).amountController.text) == 0) {
              return Utils.showToast(title: "amount don't must equal zero", state: UtilState.warning);
            } else if (WalletCubit.of(context).ibanController.text.length != 24) {
              return Utils.showToast(title: 'IBAN number must be 24 number', state: UtilState.warning);
            } else {
              await WalletCubit.of(context).addTransaction(context, TransactionTypeEnum.Withdraw.index);
            }

            // context.navigateToPage(const NewTransaction());
          },
        ),
      ],
      appBar: CustomAppBar(title: 'New Transaction'.tr()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    image: const DecorationImage(image: AssetImage(AppImages.backgroundBalance), fit: BoxFit.cover),
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
                        'Your Balance'.tr(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${ConstantModel.walletModel?.data?.balance ?? 0}',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontSize: 24.sp),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'SAR'.tr(),
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white.withOpacity(0.7)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Transaction Details'.tr(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w400),
                ),
                Text(
                  'Please enter your data'.tr(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w400, color: AppColors.textColor.withOpacity(0.6)),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  labelStringText: 'Bank Name'.tr(),
                  controller: WalletCubit.of(context).bankNameController,
                  hintText: 'Bank Name'.tr(),
                  outPadding: EdgeInsets.zero,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  labelStringText: 'Account Name'.tr(),
                  controller: WalletCubit.of(context).accountNameController,
                  hintText: 'Account Name'.tr(),
                  outPadding: EdgeInsets.zero,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  labelStringText: 'IBAN'.tr(),
                  controller: WalletCubit.of(context).ibanController,
                  hintText: 'EG322222048049822233373583413'.tr(),
                  outPadding: EdgeInsets.zero,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(24),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  labelStringText: 'Cost'.tr(),
                  controller: WalletCubit.of(context).amountController,
                  hintText: '300'.tr(),
                  outPadding: EdgeInsets.zero,
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/component/custom_text_form_field.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/extensions.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/menu/views/wallet/presentation/manager/walletCubit/cubit/wallet_cubit.dart';
import 'package:matlop_provider/feature/order/presentation/manager/offersCubit/offers_order_cubit.dart';

class AddOfferView extends StatefulWidget {
  final OffersOrderCubit cubit;
  final int idSpecialOrder;

  const AddOfferView({super.key, required this.cubit, required this.idSpecialOrder});

  @override
  State<AddOfferView> createState() => _AddOfferViewState();
}

class _AddOfferViewState extends State<AddOfferView> {
  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 1),
          Text(
            'select_price'.tr(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
          ),

          Form(
            key: globalKey,
            child: Column(
              children: [
                BlocProvider.value(
                  value: widget.cubit,
                  child: BlocBuilder<WalletCubit, WalletState>(
                    builder: (context, state) => CustomTextFormField(
                      outPadding: EdgeInsets.zero,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      controller: widget.cubit.amountController,
                      hintText: 'amount'.tr(),
                      labelText: Text('amount'.tr()),
                      textInputType: TextInputType.number,
                      // borderColor: AppColors.transparent,
                      fillColor: AppColors.scaffoldBackGround,
                      // suffixIcon: Row(
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: [
                      //     Center(child: Text('SAR'.tr())),
                      //   ],
                      // ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // CustomTextFormField(
          //   outPadding: EdgeInsets.zero,
          //   contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          //   controller: widget.cubit.descriptionCancelOrderController,
          //   hintText: 'add_description_cancellation_order'.tr(),
          //   maxLines: 5,
          // ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: CustomTextButton(
              gradientColors: true,
              onPress: () {
                if (globalKey.currentState?.validate() == false) {
                } else if (int.parse(widget.cubit.amountController.text) == 0) {
                  return Utils.showToast(title: "amount don't must equal zero", state: UtilState.warning);
                } else {
                  widget.cubit.createOffer(context, specialOrderId: widget.idSpecialOrder);
                }
              },
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text('send_offer'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
            ),
          ),
          // SizedBox(
          //   height: MediaQuery.of(context).viewInsets.bottom,
          // ),
        ].paddingDirectional(bottom: 16),
      ),
    );
  }
}

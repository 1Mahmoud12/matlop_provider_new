import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/utils/constants_enum.dart';
import 'package:matlop_provider/feature/home/presentation/widgets/dialog_offer.dart';
import 'package:matlop_provider/feature/order/presentation/manager/detailsSpecialrderCubit/details_special_order_cubit.dart';
import 'package:matlop_provider/feature/order/presentation/manager/offersCubit/offers_order_cubit.dart';

class SpecialOrderActionBtn extends StatelessWidget {
  final OffersOrderCubit? offersOrderCubit;
  final num? offerAmount;
  final bool? submitted;
  final int idSpecialOrder;

  const SpecialOrderActionBtn({
    super.key,
    this.offersOrderCubit,
    this.offerAmount,
    this.submitted,
    required this.idSpecialOrder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsSpecialOrderCubit, DetailsSpecialOrderState>(
      builder: (context, state) {
        final specialOrderModel = ConstantModel.detailsSpecialOrderModel?.data;
        if (specialOrderModel == null || specialOrderModel.specialOrderStatus == null) {
          return const SizedBox();
        }

        final status = specialOrderModel.specialOrderStatus!.toInt();

        if (status < 2) {
          if (offersOrderCubit != null && userCacheValue?.data?.profile?.roleId == 9) {
            return CustomTextButton(
              width: MediaQuery.sizeOf(context).width,
              borderRadius: 16,
              onPress: () {
                offersOrderCubit!.amountController.clear();
                offersOrderCubit!.amountController.text = '${offerAmount ?? ''}';
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: AppColors.scaffoldBackGround,
                  builder: (context) => Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: AddOfferView(
                      cubit: offersOrderCubit!,
                      idSpecialOrder: idSpecialOrder,
                    ),
                  ),
                );
              },
              child: Text(
                (submitted ?? false) ? 'Update Offer'.tr() : 'Add Offer'.tr(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            );
          } else {
            return const SizedBox();
          }
        } else if (status >= 2 && status < 5) {
          return CustomTextButton(
            width: MediaQuery.sizeOf(context).width,
            borderRadius: 16,
            onPress: () {
              if (status == 2) {
                DetailsSpecialOrderCubit.of(context).changeStatus(context, status: 3, orderId: idSpecialOrder);
              } else if (status == 3) {
                DetailsSpecialOrderCubit.of(context).changeStatus(context, status: 4, orderId: idSpecialOrder);
              } else if (status == 4) {
                DetailsSpecialOrderCubit.of(context).changeStatus(context, status: 5, orderId: idSpecialOrder);
              }
            },
            child: Text(
              OrderStatusEnum.values[status].name.tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}

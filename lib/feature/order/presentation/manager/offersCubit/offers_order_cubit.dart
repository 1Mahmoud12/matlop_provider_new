import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/utils/loading_dialog.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/order/data/dataSource/offers_order_data_source.dart';
import 'package:matlop_provider/main.dart';

part 'offers_order_state.dart';

class OffersOrderCubit extends Cubit<OffersOrderState> {
  OffersOrderCubit() : super(OffersOrderInitial());

  static OffersOrderCubit of(BuildContext context) => BlocProvider.of<OffersOrderCubit>(context);

  void getOffersOrderByStatus(BuildContext context, {int? status, int? type}) async {
    emit(OffersOrderLoading());

    await OffersOrderDataSource.getOffersOrdersByStatus(context: context).then(
      (value) {
        value.fold((l) {
          // Utils.showToast(title: l.errMessage, state: UtilState.error);
          emit(OffersOrderError(e: l.errMessage));
        }, (r) {
          ConstantModel.offersModel = r;
          // logger.i(r.toJson());
          emit(OffersOrderSuccess());
        });
      },
    );
  }

  TextEditingController amountController = TextEditingController();

  void createOffer(BuildContext context, {required int specialOrderId}) async {
    emit(OffersOrderLoading());
    animationDialogLoading(context);
    await OffersOrderDataSource.createSpecialOrderOffer(context: context, specialOrderId: specialOrderId, price: num.parse(amountController.text))
        .then(
      (value) {
        if (context.mounted) closeDialog(context);
        value.fold((l) {
          // Utils.showToast(title: l.errMessage, state: UtilState.error);
          emit(OffersOrderError(e: l.errMessage));
        }, (r) {
          Navigator.pop(context);
          Utils.showToast(title: r, state: UtilState.success);
          emit(OffersOrderSuccess());
        });
      },
    );
  }
}

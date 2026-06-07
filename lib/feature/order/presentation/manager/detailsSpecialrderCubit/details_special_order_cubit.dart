import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/loading_widget.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/order/data/dataSource/special_order_data_source.dart';
import 'package:matlop_provider/main.dart';


part 'details_special_order_state.dart';

class DetailsSpecialOrderCubit extends Cubit<DetailsSpecialOrderState> {
  DetailsSpecialOrderCubit() : super(DetailsSpecialOrderInitial());
  static DetailsSpecialOrderCubit of(BuildContext context) => BlocProvider.of<DetailsSpecialOrderCubit>(context);

  void getDetailsSpecialOrderDetails(BuildContext context, {required int orderId}) async {
    emit(DetailsSpecialOrderLoading());
    animationDialogLoading(context);

    await SpecialOrderDataSource.getSpecialOrderDetails(context: context, orderId: orderId).then(
      (value) {
        if (context.mounted) closeDialog(context);
        value.fold((l) {
          Utils.showToast(title: l.errMessage, state: UtilState.error);
          emit(DetailsSpecialOrderError(e: l.errMessage));
        }, (r) {
          ConstantModel.detailsSpecialOrderModel = r;
          emit(DetailsSpecialOrderSuccess());
        });
      },
    );
  }

  void changeStatus(BuildContext context, {required int orderId, required int status}) async {
    animationDialogLoading(context);
    emit(ChangeSpecialStatusLoading());
    await SpecialOrderDataSource.changeStatus(status: status, orderId: orderId).then(
      (value) async {
        if (context.mounted) closeDialog(context);
        value.fold((l) {
          Utils.showToast(title: l.errMessage, state: UtilState.error);
          emit(ChangeSpecialStatusError(e: l.errMessage));
        }, (r) {
          Utils.showToast(title: r, state: UtilState.success);
          emit(ChangeSpecialStatusSuccess(newStatus: status));
        });
      },
    );
  }
}

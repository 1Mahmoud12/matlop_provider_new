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
        value.fold((l) {
          Utils.showToast(title: l.errMessage, state: UtilState.error);
          closeDialog(context);

          emit(DetailsSpecialOrderError(e: l.errMessage));
        }, (r) {
          logger.i(r.toJson());
          ConstantModel.detailsSpecialOrderModel = r;
          closeDialog(context);
          emit(DetailsSpecialOrderSuccess());
        });
      },
    );
  }
}

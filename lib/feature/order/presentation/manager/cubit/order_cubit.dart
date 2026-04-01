import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/loading_widget.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/order/data/dataSource/order_data_source.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  static OrderCubit of(BuildContext context) => BlocProvider.of<OrderCubit>(context);

  void getOrderByStatus(BuildContext context, {int? status}) async {
    emit(OrderLoading());

    await orderDataSource.getOrdersByStatus(context: context, status: status).then(
      (value) {
        value.fold((l) {
          //   Utils.showToast(title: l.errMessage, state: UtilState.error);
          emit(OrderError(e: l.errMessage));
        }, (r) {
          ConstantModel.orderModel = r;
          emit(OrderSuccess());
        });
      },
    );
  }

  final OrderDataSource orderDataSource = OrderDataSourceImpl();

  void getOrderDetails(BuildContext context, {required int orderId}) async {
    animationDialogLoading(context);
    emit(OrderDetailsLoading());
    ConstantModel.orderDetailsModel = null;
    await orderDataSource.getOrderDetails(context: context, orderId: orderId).then(
      (value) {
        if (context.mounted) closeDialog(context);
        value.fold((l) {
          // Utils.showToast(title: l.errMessage, state: UtilState.error);

          emit(OrderDetailsError(e: l.errMessage));
        }, (r) {
          ConstantModel.orderDetailsModel = r;
          emit(OrderDetailsSuccess());
        });
      },
    );
  }

  void changeStatus(BuildContext context, {required int orderId, required int status}) async {
    animationDialogLoading(context);
    emit(ChangeStatusLoading());
    await orderDataSource.changeStatus(status: status, orderId: orderId).then(
      (value) async {
        if (context.mounted) closeDialog(context);
        value.fold((l) {
          Utils.showToast(title: l.errMessage, state: UtilState.error);

          emit(ChangeStatusError(e: l.errMessage));
        }, (r) {
          Utils.showToast(title: r, state: UtilState.success);

          emit(ChangeStatusSuccess(newStatus: status));
        });
      },
    );
  }
}

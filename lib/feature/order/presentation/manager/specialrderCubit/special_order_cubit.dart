import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/loading_widget.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/order/data/dataSource/order_data_source.dart';
import 'package:matlop_provider/feature/order/data/dataSource/special_order_data_source.dart';

part 'special_order_state.dart';

class SpecialOrderCubit extends Cubit<SpecialOrderState> {
  SpecialOrderCubit() : super(SpecialOrderInitial());
  static SpecialOrderCubit of(BuildContext context) => BlocProvider.of<SpecialOrderCubit>(context);
  void getSpecialOrderByStatus(BuildContext context, { int? status,int? type}) async {
    emit(SpecialOrderLoading());

    await SpecialOrderDataSource.getSpecialOrdersByStatus(context: context,status: status,type: type).then(
      (value) {
        value.fold((l) {
         // Utils.showToast(title: l.errMessage, state: UtilState.error);
          emit(SpecialOrderError(e: l.errMessage));
        }, (r) {
          ConstantModel.specialOrdersModel = r;
          emit(SpecialOrderSuccess());
        });
      },
    );
  }


}

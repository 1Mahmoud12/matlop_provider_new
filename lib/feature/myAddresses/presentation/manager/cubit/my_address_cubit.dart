import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/myAddresses/data/dataSource/my_address_data_source.dart';
import 'package:matlop_provider/feature/myAddresses/data/models/my_address_model.dart';

part 'my_address_state.dart';

class MyAddressCubit extends Cubit<MyAddressState> {
  MyAddressCubit() : super(MyAddressInitial());

  static MyAddressCubit of(BuildContext context) => BlocProvider.of<MyAddressCubit>(context);
  TextEditingController selectedLocation = TextEditingController();
  LocationData? locationData;

  void getMyAddress(BuildContext context) async {
    emit(MyAddressLoading());

    await MyAddressDataSource.getMyAddress(context: context).then(
      (value) {
        value.fold((l) {
          Utils.showToast(title: l.errMessage, state: UtilState.error);
          emit(MyAddressError(e: l.errMessage));
        }, (r) {
          ConstantModel.myAddressModel = r;
          emit(MyAddressSuccess());
        });
      },
    );
  }
}

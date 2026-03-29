import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/addNewAddress/data/dataSource/districts_data_source.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/manager/addNewAddress/cubit/add_new_address_cubit.dart';

part 'districts_state.dart';

class DistrictsCubit extends Cubit<DistrictsState> {
  DistrictsCubit() : super(DistrictsInitial());
  static DistrictsCubit of(BuildContext context) => BlocProvider.of<DistrictsCubit>(context);

  void getDistricts(BuildContext context) async {
    emit(DistrictsLoading());

    await DistrictsDataSource.getDistricts(cityId: AddNewAddressCubit.of(context).cityData?.cityId ?? -1, context: context).then(
      (value) {
        value.fold((l) {
          Utils.showToast(title: l.errMessage, state: UtilState.error);
          emit(DistrictsError(e: l.errMessage));
        }, (r) {
          ConstantModel.districtModel = r;
          emit(DistrictsSuccess());
        });
      },
    );
  }
}

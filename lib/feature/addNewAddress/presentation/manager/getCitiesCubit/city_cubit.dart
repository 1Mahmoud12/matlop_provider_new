import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/addNewAddress/data/dataSource/city_data_source.dart';

part 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  CityCubit() : super(CityInitial());

  static CityCubit of(BuildContext context) => BlocProvider.of<CityCubit>(context);
  TextEditingController selectedCity = TextEditingController();
  void getCities(BuildContext context, {required int countryId}) async {
    emit(CityLoading());

    await CityDataSource.getCities(countryId: countryId, context: context).then(
      (value) {
        value.fold((l) {
          Utils.showToast(title: l.errMessage, state: UtilState.error);
          emit(CityError(e: l.errMessage));
        }, (r) {
          ConstantModel.cityModel = r;
          log('ahmed${ConstantModel.cityModel!.message}');

          emit(CitySuccess());
        });
      },
    );
  }

  void getCityName(String cityName) {
    selectedCity.text = cityName;
  }
}

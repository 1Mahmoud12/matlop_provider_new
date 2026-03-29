import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/addNewAddress/data/dataSource/country_data_source.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  CountryCubit() : super(CountryInitial());

  static CountryCubit of(BuildContext context) => BlocProvider.of<CountryCubit>(context);

  void getCountries(BuildContext context) async {
    emit(CountryILoading());

    await CountryDataSource.getCounties(context: context).then(
      (value) {
        value.fold((l) {
        //  Utils.showToast(title: l.errMessage, state: UtilState.error);
          emit(CountryError(e: l.errMessage));
        }, (r) {
          ConstantModel.countryModel = r;
          emit(CountrySuccess());
        });
      },
    );
  }
}

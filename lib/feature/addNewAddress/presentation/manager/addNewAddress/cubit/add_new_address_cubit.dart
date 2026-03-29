import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/loading_widget.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/addNewAddress/data/dataSource/addLoacation_data_source.dart';
import 'package:matlop_provider/feature/addNewAddress/data/models/add_location_parameter.dart';
import 'package:matlop_provider/feature/addNewAddress/data/models/city_model.dart';
import 'package:matlop_provider/feature/addNewAddress/data/models/country_model.dart';
import 'package:matlop_provider/feature/addNewAddress/data/models/districts_model.dart';
import 'package:matlop_provider/feature/myAddresses/presentation/manager/cubit/my_address_cubit.dart';

part 'add_new_address_state.dart';

class AddNewAddressCubit extends Cubit<AddNewAddressState> {
  AddNewAddressCubit() : super(AddNewAddressInitial());

  static AddNewAddressCubit of(BuildContext context) => BlocProvider.of<AddNewAddressCubit>(context);
  TextEditingController locationController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController buildingNOController = TextEditingController();
  TextEditingController districtsController = TextEditingController();

  CountryData? countryData;
  CityData? cityData;
  DistrictData? districtData;

  String lat = '';
  String lon = '';

  Future<void> addNewAddress(BuildContext context) async {
    emit(AddNewAddressLoading());
    animationDialogLoading(context);
    await AddLocationDataSource.postLocation(
      locationParameters: LocationParameter(
        countryId: countryData?.countryId ?? -1,
        cityId: cityData?.cityId ?? -1,
        districtId: districtData?.districtId ?? -1,
        blockNo: districtsController.text,
        latitude: lat,
        longitude: lon,
        userId: userCacheValue?.data?.userId ?? -1,
        enName: locationController.text,
      ),
      context: context,
    ).then(
      (value) {
        closeDialog(context);
        value.fold((l) {
          Utils.showToast(title: l.errMessage, state: UtilState.error);
          emit(AddNewAddressError(e: l.errMessage));
        }, (r) {
          MyAddressCubit.of(context).getMyAddress(context);
          Utils.showToast(title: 'Address Add Successfully', state: UtilState.success);
          locationController.clear();
          countryController.clear();
          cityController.clear();
          buildingNOController.clear();
          districtsController.clear();
          Navigator.pop(context);
          emit(AddNewAddressSuccess());
        });
      },
    );
  }
}

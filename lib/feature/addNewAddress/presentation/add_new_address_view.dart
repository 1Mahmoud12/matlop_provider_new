import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/component/custom_app_bar.dart';
import 'package:matlop_provider/core/component/custom_text_form_field.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/manager/addNewAddress/cubit/add_new_address_cubit.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/manager/getCitiesCubit/city_cubit.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/manager/getDistricts/cubit/districts_cubit.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/widgets/map_card.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/widgets/select_city_bottom_sheet.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/widgets/select_country_bottom_sheet.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/widgets/select_district_bottom_sheet.dart';

class AddNewAddressView extends StatefulWidget {
  const AddNewAddressView({super.key});

  @override
  State<AddNewAddressView> createState() => _AddNewAddressViewState();
}

class _AddNewAddressViewState extends State<AddNewAddressView> {
  final _formKey = GlobalKey<FormState>();

  // FocusNodes for text fields
  final FocusNode _countryFocusNode = FocusNode();
  final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _districtFocusNode = FocusNode();
  final FocusNode _locationNameFocusNode = FocusNode();
  final FocusNode _buildingNoFocusNode = FocusNode();

  @override
  void dispose() {
    _countryFocusNode.dispose();
    _cityFocusNode.dispose();
    _districtFocusNode.dispose();
    _locationNameFocusNode.dispose();
    _buildingNoFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add New Address'.tr(),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const MapCard(),
                const SizedBox(height: 20),
                Text(
                  'Location details'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16.sp),
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  labelStringText: 'Location name'.tr(),
                  controller: AddNewAddressCubit.of(context).locationController,
                  hintText: 'Location name'.tr(),
                  outPadding: EdgeInsets.zero,
                  borderColor: Colors.grey.withOpacity(0.2),
                  focusNode: _locationNameFocusNode,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _locationNameFocusNode.unfocus();
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return const SelectCountryBottomSheet();
                            },
                          );
                        },
                        child: CustomTextFormField(
                          labelStringText: 'Country'.tr(),
                          controller: AddNewAddressCubit.of(context).countryController,
                          hintText: 'Country'.tr(),
                          outPadding: EdgeInsets.zero,
                          borderColor: Colors.grey.withOpacity(0.2),
                          suffixIcon: const Icon(Icons.keyboard_arrow_down_sharp),
                          focusNode: _countryFocusNode,
                          enable: false,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _locationNameFocusNode.unfocus();
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (context) => CityCubit(),
                                  ),
                                  BlocProvider(
                                    create: (context) => AddNewAddressCubit(),
                                  ),
                                ],
                                child: const SelectCityBottomSheet(),
                              );
                            },
                          );
                        },
                        child: CustomTextFormField(
                          labelStringText: 'City'.tr(),
                          controller: AddNewAddressCubit.of(context).cityController,
                          hintText: 'City'.tr(),
                          outPadding: EdgeInsets.zero,
                          borderColor: Colors.grey.withOpacity(0.2),
                          suffixIcon: const Icon(Icons.keyboard_arrow_down_sharp),
                          focusNode: _cityFocusNode,
                          enable: false,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  labelStringText: 'Building no'.tr(),
                  controller: AddNewAddressCubit.of(context).buildingNOController,
                  hintText: 'Building no'.tr(),
                  outPadding: EdgeInsets.zero,
                  borderColor: Colors.grey.withOpacity(0.2),
                  textInputType: TextInputType.number,
                  focusNode: _buildingNoFocusNode,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _locationNameFocusNode.unfocus();
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return MultiBlocProvider(providers: [
                          BlocProvider(
                            create: (context) => DistrictsCubit(),
                          ),
                          BlocProvider(
                            create: (context) => AddNewAddressCubit(),
                          ),
                        ], child: const SelectDistrictBottomSheet());
                      },
                    );
                  },
                  child: CustomTextFormField(
                    labelStringText: 'Districts'.tr(),
                    controller: AddNewAddressCubit.of(context).districtsController,
                    hintText: 'Districts'.tr(),
                    outPadding: EdgeInsets.zero,
                    borderColor: Colors.grey.withOpacity(0.2),
                    suffixIcon: const Icon(Icons.keyboard_arrow_down_sharp),
                    focusNode: _districtFocusNode,
                    enable: false,
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextButton(
                  onPress: () {
                    if (_formKey.currentState!.validate() && AddNewAddressCubit.of(context).lat.isNotEmpty) {
                      AddNewAddressCubit.of(context).addNewAddress(context);
                    }
                    if (AddNewAddressCubit.of(context).lat.isEmpty) {
                      Utils.showToast(title: 'Select location', state: UtilState.error);
                    }
                  },
                  borderRadius: 15,
                  gradientColors: true,
                  child: Text(
                    'Add new address'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.white),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

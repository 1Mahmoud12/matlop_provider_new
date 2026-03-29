import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/loading_widget.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/feature/addNewAddress/data/models/country_model.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/manager/addNewAddress/cubit/add_new_address_cubit.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/manager/getCountriesCubit/country_cubit.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/widgets/city_widget.dart';

class SelectCountryBottomSheet extends StatefulWidget {
  final void Function(CountryData countryData)? onTap;
  const SelectCountryBottomSheet({
    super.key,
    this.onTap,
  });

  @override
  State<SelectCountryBottomSheet> createState() => _SelectCountryBottomSheetState();
}

class _SelectCountryBottomSheetState extends State<SelectCountryBottomSheet> {
  final CountryCubit countryCubit = CountryCubit();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        countryCubit.getCountries(context);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.3, // Initial height of the bottom sheet
      minChildSize: 0.3, // Minimum height
      maxChildSize: 0.9, // Maximum height when fully expanded
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select Country'.tr(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocProvider.value(
                  value: countryCubit,
                  child: BlocBuilder<CountryCubit, CountryState>(
                    builder: (context, state) {
                      return state is CountryILoading
                          ? const LoadingWidget()
                          : state is CountrySuccess
                              ? ConstantModel.countryModel?.data.isEmpty ?? true
                                  ? Center(
                                      child: Text(
                                        'No countries available'.tr(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : Column(
                                      children: List.generate(ConstantModel.countryModel?.data.length ?? 0, (index) {
                                        return CityWidget(
                                          onTap: () {
                                            setState(() {
                                              AddNewAddressCubit.of(context).countryData = ConstantModel.countryModel?.data[index];
                                              AddNewAddressCubit.of(context).countryController.text =
                                                  AddNewAddressCubit.of(context).countryData?.enName ?? 'Null';
                                            });
                                            widget.onTap?.call(ConstantModel.countryModel!.data[index]);
                                            Navigator.pop(context);
                                          },
                                          text: ConstantModel.countryModel?.data[index].enName ?? 'null',
                                        );
                                      }),
                                    )
                              : state is CountryError
                                  ? Text(state.e)
                                  : const Text('Something went wrong');
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/loading_widget.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/manager/addNewAddress/cubit/add_new_address_cubit.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/manager/getCitiesCubit/city_cubit.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/widgets/city_widget.dart';

class SelectCityBottomSheet extends StatefulWidget {
  const SelectCityBottomSheet({
    super.key,
  });

  @override
  State<SelectCityBottomSheet> createState() => _SelectCityBottomSheetState();
}

class _SelectCityBottomSheetState extends State<SelectCityBottomSheet> {
  @override
  void initState() {
    if (AddNewAddressCubit.of(context).countryController.text.isNotEmpty) {
      CityCubit.of(context).getCities(
        context,
        countryId: AddNewAddressCubit.of(context).countryData?.countryId ?? -1,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CityCubit, CityState>(
      builder: (context, state) {
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
              child: AddNewAddressCubit.of(context).countryController.text.isEmpty
                  ? Center(
                      child: Text(
                        'you should select country first'.tr(), // Natural format
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    )
                  : state is CityLoading
                      ? const LoadingWidget()
                      : state is CitySuccess
                          ? ConstantModel.cityModel?.data.isEmpty ?? true
                              ? Center(
                                  child: Text(
                                    'no cities available'.tr(), // Natural format
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                )
                              : SingleChildScrollView(
                                  controller: scrollController,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'select city'.tr(), // Natural format
                                        style: Theme.of(context).textTheme.bodyLarge,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        children: List.generate(
                                          ConstantModel.cityModel?.data.length ?? 0,
                                          (index) {
                                            return CityWidget(
                                              onTap: () {
                                                AddNewAddressCubit.of(context).cityData =
                                                    ConstantModel.cityModel?.data[index];
                                                AddNewAddressCubit.of(context).cityController.text =
                                                    ConstantModel.cityModel?.data[index].enName ?? 'null';
                                                Navigator.pop(context);
                                              },
                                              text: ConstantModel.cityModel?.data[index].enName ?? 'null',
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                          : state is CityError
                              ? Center(
                                  child: Text(
                                    state.e,
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                )
                              : const Center(
                                  child: Text('Something went wrong'),
                                ),
            );
          },
        );
      },
    );
  }
}

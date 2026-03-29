import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/loading_widget.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/manager/addNewAddress/cubit/add_new_address_cubit.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/manager/getDistricts/cubit/districts_cubit.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/widgets/city_widget.dart';

class SelectDistrictBottomSheet extends StatefulWidget {
  const SelectDistrictBottomSheet({
    super.key,
  });

  @override
  State<SelectDistrictBottomSheet> createState() => _SelectDistrictBottomSheetState();
}

class _SelectDistrictBottomSheetState extends State<SelectDistrictBottomSheet> {
  @override
  void initState() {
    if (AddNewAddressCubit.of(context).cityController.text.isNotEmpty) {
      DistrictsCubit.of(context).getDistricts(context);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.3, // Initial height of the bottom sheet
      minChildSize: 0.3, // Minimum height
      maxChildSize: 0.9, // Maximum height when fully expanded
      builder: (context, scrollController) {
        return BlocBuilder<DistrictsCubit, DistrictsState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: AddNewAddressCubit.of(context).cityController.text.isEmpty
                  ? Center(
                      child: Text(
                        'you should select a city first'.tr(), // Natural format
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    )
                  : state is DistrictsLoading
                      ? const LoadingWidget()
                      : state is DistrictsSuccess
                          ? ConstantModel.districtModel?.data.isEmpty ?? true
                              ? Center(
                                  child: Text(
                                    'no districts available'.tr(), // Natural format
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
                                        'select districts'.tr(), // Natural format
                                        style: Theme.of(context).textTheme.bodyLarge,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        children: List.generate(
                                          ConstantModel.districtModel?.data.length ?? 0,
                                          (index) {
                                            return CityWidget(
                                              onTap: () {
                                                AddNewAddressCubit.of(context).districtData = ConstantModel.districtModel?.data[index];
                                                AddNewAddressCubit.of(context).districtsController.text =
                                                    ConstantModel.districtModel?.data[index].enName ?? 'null';
                                                Navigator.pop(context);
                                              },
                                              text: ConstantModel.districtModel?.data[index].enName ?? 'null',
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                          : state is DistrictsError
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

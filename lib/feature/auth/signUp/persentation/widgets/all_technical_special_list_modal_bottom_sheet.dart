import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/loading_widget.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/core/utils/server_error_widget.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/feature/auth/signUp/persentation/manager/register_cubit.dart';

class SelectTechnicalSpecialListBottomSheet extends StatefulWidget {
  final RegisterCubit registerCubit;

  const SelectTechnicalSpecialListBottomSheet({super.key, required this.registerCubit});

  @override
  State<SelectTechnicalSpecialListBottomSheet> createState() => _SelectTechnicalSpecialListBottomSheetState();
}

class _SelectTechnicalSpecialListBottomSheetState extends State<SelectTechnicalSpecialListBottomSheet> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        widget.registerCubit.getAllTechnicalSpecial(context: context);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4, // Start with 40% height
      minChildSize: 0.3, // Minimum height
      maxChildSize: 0.9, // Maximum height
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: BlocProvider.value(
            value: widget.registerCubit,
            child: BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                return state is GetAllTechnicalSpecialListLoading
                    ? const LoadingWidget()
                    : state is GetAllTechnicalSpecialListSuccess || state is AddTechnicalState
                        ? SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Select your technical special'.tr(),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                if (ConstantModel.technicalSpecialListModel?.data?.isEmpty ?? true)
                                  Container(
                                    padding: const EdgeInsets.only(top: 40),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Text(
                                            'There is technical special'.tr(),
                                            style: Theme.of(context).textTheme.bodyLarge,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  )
                                else
                                  Column(
                                    children: List.generate(ConstantModel.technicalSpecialListModel?.data?.length ?? 0, (index) {
                                      final item = ConstantModel.technicalSpecialListModel?.data?[index];
                                      if (item == null) return const SizedBox.shrink();
                                      final isSelected = widget.registerCubit.selectedTechnicals
                                          .any((e) => e.technicalSpecialistId == item.technicalSpecialistId);
                                      return CheckboxListTile(
                                        value: isSelected,
                                        title: Text(item.enName ?? Constants.unKnownValue),
                                        onChanged: (value) {
                                          widget.registerCubit.toggleTechnicalSpecial(technical: item);
                                        },
                                        controlAffinity: ListTileControlAffinity.leading,
                                        activeColor: Theme.of(context).primaryColor,
                                        contentPadding: EdgeInsets.zero,
                                      );
                                    }),
                                  ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: CustomTextButton(
                                    gradientColors: true,
                                    stops: const [0.5, 1],
                                    onPress: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Done'.tr(),
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : state is GetAllTechnicalSpecialListError
                            ? Column(
                                children: [
                                  ServerErrorWidget(
                                    data: state.e,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // Center(
                                  //   child: CustomTextButton(
                                  //     borderRadius: 16,
                                  //     onPress: () {
                                  //       context.navigateToPage(const AddNewAddressView());
                                  //     },
                                  //     child: Text(
                                  //       'Add Location'.tr(),
                                  //       style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              )
                            : Text('Something went wrong'.tr());
              },
            ),
          ),
        );
      },
    );
  }
}

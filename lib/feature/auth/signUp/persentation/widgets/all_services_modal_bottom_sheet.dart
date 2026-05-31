import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/loading_widget.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/core/utils/server_error_widget.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/feature/auth/signUp/persentation/manager/register_cubit.dart';

class SelectServicesBottomSheet extends StatefulWidget {
  final RegisterCubit registerCubit;

  const SelectServicesBottomSheet({super.key, required this.registerCubit});

  @override
  State<SelectServicesBottomSheet> createState() => _SelectServicesBottomSheetState();
}

class _SelectServicesBottomSheetState extends State<SelectServicesBottomSheet> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        widget.registerCubit.getAllServices(context: context);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
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
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Select services'.tr(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 20),
                          Flexible(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  if (ConstantModel.servicesListModel?.data?.isEmpty ?? true)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 40),
                                      child: Center(
                                        child: Text(
                                          'No services found'.tr(),
                                          style: Theme.of(context).textTheme.bodyLarge,
                                        ),
                                      ),
                                    )
                                  else
                                    Column(
                                      children: List.generate(
                                        ConstantModel.servicesListModel?.data?.length ?? 0,
                                        (index) {
                                          final item = ConstantModel.servicesListModel?.data?[index];
                                          if (item == null) return const SizedBox.shrink();
                                          final isSelected =
                                              widget.registerCubit.selectedServices.any((e) => e.technicalSpecialistId == item.technicalSpecialistId);
                                          bool isAr = context.locale.languageCode == 'ar';
                                          return CheckboxListTile(
                                            value: isSelected,
                                            title: Text(
                                                isAr ? (item.arName ?? Constants.unKnownValue) : (item.enName ?? Constants.unKnownValue)),
                                            onChanged: (value) {
                                              widget.registerCubit.toggleService(service: item, context: context);
                                            },
                                            controlAffinity: ListTileControlAffinity.leading,
                                            activeColor: Theme.of(context).primaryColor,
                                            contentPadding: EdgeInsets.zero,
                                          );
                                        },
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: CustomTextButton(
                              gradientColors: true,
                              stops: const [0.5, 1],
                              onPress: () => Navigator.pop(context),
                              child: Text(
                                'Done'.tr(),
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    : state is GetAllTechnicalSpecialListError
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ServerErrorWidget(data: state.e),
                              const SizedBox(height: 20),
                            ],
                          )
                        : Text('Something went wrong'.tr());
          },
        ),
      ),
    );
  }
}

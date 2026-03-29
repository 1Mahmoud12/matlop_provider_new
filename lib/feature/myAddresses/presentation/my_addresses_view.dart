import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/component/custom_app_bar.dart';
import 'package:matlop_provider/core/component/loading_widget.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/add_new_address_view.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/widgets/city_widget.dart';
import 'package:matlop_provider/feature/myAddresses/presentation/manager/cubit/my_address_cubit.dart';

class MyAddressesView extends StatefulWidget {
  const MyAddressesView({super.key});

  @override
  State<MyAddressesView> createState() => _MyAddressesViewState();
}

class _MyAddressesViewState extends State<MyAddressesView> {
  @override
  void initState() {
    MyAddressCubit.of(context).getMyAddress(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'My Address'.tr()),
      body: BlocBuilder<MyAddressCubit, MyAddressState>(
        builder: (context, state) {
          return state is MyAddressLoading
              ? const LoadingWidget()
              : state is MyAddressSuccess
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: ConstantModel.myAddressModel?.data == null || ConstantModel.myAddressModel!.data.isEmpty
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('There is no address available'.tr()),
                                        const SizedBox(height: 20),
                                        CustomTextButton(
                                          onPress: () {
                                            context.navigateToPage(const AddNewAddressView());
                                          },
                                          borderRadius: 15,
                                          child: Text(
                                            'Add new address'.tr(),
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: ConstantModel.myAddressModel?.data.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return CityWidget(
                                        text: ConstantModel.myAddressModel?.data[index].enName ?? 'null',
                                      );
                                    },
                                  ),
                          ),
                          if (ConstantModel.myAddressModel?.data != null && ConstantModel.myAddressModel!.data.isNotEmpty)
                            CustomTextButton(
                              onPress: () {
                                context.navigateToPage(const AddNewAddressView());
                              },
                              borderRadius: 15,
                              child: Text(
                                'Add new address'.tr(),
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                              ),
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  : state is MyAddressError
                      ? Center(
                          child: Column(
                            children: [
                              const Spacer(),
                              Text('There was an error loading addresses'.tr()),
                              const SizedBox(height: 20),
                              CustomTextButton(
                                onPress: () {
                                  context.navigateToPage(const AddNewAddressView());
                                },
                                borderRadius: 15,
                                child: Text(
                                  'Add new address'.tr(),
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        )
                      : const SizedBox.shrink();
        },
      ),
    );
  }
}

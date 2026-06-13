import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/loading_widget.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/feature/home/presentation/widgets/special_order_card.dart';
import 'package:matlop_provider/feature/order/presentation/manager/offersCubit/offers_order_cubit.dart';
import 'package:matlop_provider/feature/order/presentation/widgets/empty_orders.dart';

class OffersOrderList extends StatefulWidget {
  const OffersOrderList({super.key});

  @override
  State<OffersOrderList> createState() => _OffersOrderListListState();
}

class _OffersOrderListListState extends State<OffersOrderList> {
  final OffersOrderCubit offersOrderCubit = OffersOrderCubit();

  @override
  void initState() {
    offersOrderCubit.getOffersOrderByStatus(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: offersOrderCubit,
      child: BlocBuilder<OffersOrderCubit, OffersOrderState>(
        buildWhen: (previousState, currentState) {
          return currentState is OffersOrderLoading || currentState is OffersOrderError || currentState is OffersOrderSuccess;
        },
        builder: (context, state) {
          if (state is OffersOrderLoading && ConstantModel.offersModel == null) {
            return const Center(child: LoadingWidget());
          } else if (state is OffersOrderError) {
            return const EmptyOrders();
          } else if (ConstantModel.offersModel != null) {
            if (ConstantModel.offersModel!.data == null || ConstantModel.offersModel!.data!.isEmpty) {
              return const EmptyOrders();
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: ConstantModel.offersModel?.data?.length ?? 0,
              itemBuilder: (context, index) {
                return (ConstantModel.offersModel!.data![index].isNew ?? false)
                    ? SpecialOrderCard(
                        itemSpecialOrder: ConstantModel.offersModel!.data![index],
                        offersOrderCubit: offersOrderCubit,
                      )
                    : const SizedBox.shrink();
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

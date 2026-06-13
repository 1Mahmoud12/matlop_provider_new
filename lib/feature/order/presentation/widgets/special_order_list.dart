import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/loading_widget.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/feature/home/presentation/widgets/special_order_card.dart';
import 'package:matlop_provider/feature/order/presentation/manager/specialrderCubit/special_order_cubit.dart';
import 'package:matlop_provider/feature/order/presentation/widgets/empty_orders.dart';

class SpecialOrderList extends StatefulWidget {
  final int? status;
  final int? type;

  const SpecialOrderList({super.key, this.status, this.type});

  @override
  State<SpecialOrderList> createState() => _SpecialOrderListState();
}

class _SpecialOrderListState extends State<SpecialOrderList> {
  @override
  void initState() {
    SpecialOrderCubit.of(context).getSpecialOrderByStatus(context, status: widget.status, type: widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpecialOrderCubit, SpecialOrderState>(
      buildWhen: (previousState, currentState) {
        return currentState is SpecialOrderLoading || currentState is SpecialOrderError || currentState is SpecialOrderSuccess;
      },
      builder: (context, state) {
        if (state is SpecialOrderLoading && ConstantModel.specialOrdersModel == null) {
          return const Center(child: LoadingWidget());
        } else if (state is SpecialOrderError) {
          return const EmptyOrders();
        } else if (ConstantModel.specialOrdersModel != null) {
          if (ConstantModel.specialOrdersModel!.data == null || ConstantModel.specialOrdersModel!.data!.isEmpty) {
            return const EmptyOrders();
          }
          return ListView.builder(
            itemCount: ConstantModel.specialOrdersModel?.data?.length ?? 0,
            itemBuilder: (context, index) {
              return SpecialOrderCard(
                itemSpecialOrder: ConstantModel.specialOrdersModel!.data![index],
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}

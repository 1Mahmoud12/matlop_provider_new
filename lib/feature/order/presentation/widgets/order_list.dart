import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/loading_widget.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/feature/order/presentation/manager/cubit/order_cubit.dart';
import 'package:matlop_provider/feature/order/presentation/widgets/empty_orders.dart';
import 'package:matlop_provider/feature/order/presentation/widgets/order_card_status.dart';

class OrderList extends StatefulWidget {
  final int? status;
  const OrderList({super.key, this.status});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  void initState() {
    OrderCubit.of(context).getOrderByStatus(context, status: widget.status);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      buildWhen: (previousState, currentState) {
        return currentState is OrderLoading || currentState is OrderError || currentState is OrderSuccess;
      },
      builder: (context, state) {
        if (state is OrderLoading) {
          return const Center(child: LoadingWidget());
        }
        else if (state is OrderError) {
          return const EmptyOrders();
        }
        else if (state is OrderSuccess) {
          if (ConstantModel.orderModel != null && ConstantModel.orderModel!.data!.isEmpty) {
            return const EmptyOrders();
          }
          return ListView.builder(
            itemCount: ConstantModel.orderModel?.data?.length ?? 0,
            itemBuilder: (context, index) {
              return OrderCardWithStatus(
                orderData: ConstantModel.orderModel!.data![index],
              );
            },
          );
        }
        return const SizedBox();
      },
    );
 
 
 
  }
}

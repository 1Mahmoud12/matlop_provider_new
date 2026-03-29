// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:matlop_provider/core/component/loading_widget.dart';
// import 'package:matlop_provider/core/utils/constant_model.dart';
// import 'package:matlop_provider/feature/home/presentation/widgets/special_order_card.dart';
// import 'package:matlop_provider/feature/order/presentation/manager/cubit/order_cubit.dart';
// import 'package:matlop_provider/feature/order/presentation/manager/specialrderCubit/details_special_order_cubit.dart';
// import 'package:matlop_provider/feature/order/presentation/widgets/empty_orders.dart';
//
// class SpecialSpecialOrderList extends StatefulWidget {
//   const SpecialSpecialOrderList({
//     super.key,
//   });
//
//   @override
//   State<SpecialSpecialOrderList> createState() => _SpecialOrderListState();
// }
//
// class _SpecialOrderListState extends State<SpecialSpecialOrderList> {
//   @override
//   void initState() {
//     SpecialOrderCubit.of(context).getSpecialOrderByStatus(context);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SpecialOrderCubit, SpecialOrderState>(
//       builder: (context, state) {
//         if (state is SpecialOrderLoading) {
//           return const Center(child: LoadingWidget());
//         } else if (ConstantModel.specialOrdersModel!.data!.isEmpty) {
//           return const EmptyOrders();
//         } else if (state is SpecialOrderSuccess) {
//           return ListView.builder(
//               itemCount: ConstantModel.specialOrdersModel?.data?.length ?? 0,
//               itemBuilder: (context, index) {
//                 return  SpecialOrderCard(
//                      itemSpecialOrder: ConstantModel.specialOrdersModel!.data![index],
//                     );
//               });
//         } else if (state is SpecialOrderError) {
//           return Center(child: Text(state.e));
//         }
//         return const SizedBox();
//       },
//     );
//   }
// }

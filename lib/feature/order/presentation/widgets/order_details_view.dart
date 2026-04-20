import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/component/custom_app_bar.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/utils/empty_data_widget.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/core/utils/constants_enum.dart';
import 'package:matlop_provider/feature/chat/presentation/messages_screen.dart';
import 'package:matlop_provider/feature/home/presentation/widgets/plan_details_order_details.dart';
import 'package:matlop_provider/feature/home/presentation/widgets/order_billing_details_widget.dart';
import 'package:matlop_provider/feature/home/presentation/widgets/order_schedules_list_widget.dart';
import 'package:matlop_provider/feature/order/presentation/manager/cubit/order_cubit.dart';
import 'package:matlop_provider/feature/order/presentation/widgets/custom_stepper_widget.dart';
import 'package:matlop_provider/feature/order/presentation/widgets/media_list.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsView extends StatefulWidget {
  const OrderDetailsView({super.key, required this.orderData});

  final int orderData;

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      OrderCubit.of(context).getOrderDetails(context, orderId: widget.orderData);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        OrderCubit.of(context).getOrderDetails(context, orderId: widget.orderData);
      },
      backgroundColor: AppColors.scaffoldBackGround,
      color: AppColors.primaryColor,
      child: Scaffold(
        persistentFooterButtons: [
          BlocBuilder<OrderCubit, OrderState>(
            builder: (context, state) => ConstantModel.orderDetailsModel != null &&
                    ConstantModel.orderDetailsModel!.data != null &&
                    ConstantModel.orderDetailsModel!.data!.orderStatusEnum! >= 2 &&
                    ConstantModel.orderDetailsModel!.data!.orderStatusEnum! < 5
                ? CustomTextButton(
                    width: MediaQuery.sizeOf(context).width,
                    borderRadius: 16,
                    onPress: () {
                      if (ConstantModel.orderDetailsModel!.data!.orderStatusEnum == 2) {
                        OrderCubit.of(context).changeStatus(context, status: 3, orderId: widget.orderData);
                      } else if (ConstantModel.orderDetailsModel!.data!.orderStatusEnum == 3) {
                        OrderCubit.of(context).changeStatus(context, status: 4, orderId: widget.orderData);
                      } else if (ConstantModel.orderDetailsModel!.data!.orderStatusEnum == 4) {
                        OrderCubit.of(context).changeStatus(context, status: 5, orderId: widget.orderData);
                      } // context.navigateToPage(const ConfirmPaymentView());
                    },
                    child: Text(
                      OrderStatusEnum.values[ConstantModel.orderDetailsModel!.data!.orderStatusEnum ?? 0].name.tr(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                    ),
                  )
                : const SizedBox(),
          )
        ],
        appBar: CustomAppBar(
          title: 'Order Details'.tr(),
        ),
        body: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) => ConstantModel.orderDetailsModel != null && ConstantModel.orderDetailsModel!.data != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        BlocConsumer<OrderCubit, OrderState>(
                          listener: (context, state) {
                            if (state is ChangeStatusSuccess) {
                              ConstantModel.orderDetailsModel!.data!.orderStatusEnum = state.newStatus;
                            }
                          },
                          builder: (context, state) {
                            log('re build new build state $state');
                            return state is ChangeStatusSuccess
                                ? CustomStepper(
                                    selectedStatus: state.newStatus,
                                  )
                                : ConstantModel.orderDetailsModel!.data!.orderStatusEnum! < 7
                                    ? CustomStepper(
                                        selectedStatus: ConstantModel.orderDetailsModel!.data!.orderStatusEnum ?? -1,
                                      )
                                    : const SizedBox();
                          },
                        ),
                        //  const SizedBox(height: 20),
                        if (ConstantModel.orderDetailsModel!.data!.media != null && ConstantModel.orderDetailsModel!.data!.media!.isNotEmpty) ...[
                          Text(
                            'Order Image'.tr(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 15),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DottedBorder(
                              options: RectDottedBorderOptions(
                                color: Colors.grey.withOpacity(0.4),
                                padding: const EdgeInsets.all(6),
                              ),
                              child: MediaList(mediaList: ConstantModel.orderDetailsModel!.data!.media!),
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                        Text(
                          'Package Details'.tr(),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16.sp),
                        ),
                        const SizedBox(height: 15),
                        PlanDetailsOrderDetails(
                          orderData: ConstantModel.orderDetailsModel!.data!,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Billing Details'.tr(),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16.sp),
                        ),
                        const SizedBox(height: 15),
                        OrderBillingDetailsWidget(
                          orderData: ConstantModel.orderDetailsModel!.data!,
                        ),
                        if (ConstantModel.orderDetailsModel!.data?.orderSchedules != null &&
                            ConstantModel.orderDetailsModel!.data!.orderSchedules!.isNotEmpty) ...[
                              SizedBox(height: 15.h),
                          Text(
                            'Visits Schedule'.tr(),
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16.sp),
                          ),
                          // const SizedBox(height: 15),
                          const SizedBox(height: 15),
                          OrderSchedulesListWidget(
                            schedules: ConstantModel.orderDetailsModel!.data!.orderSchedules!,
                          ),
                        ],
                        SizedBox(height: 150.h),
                      ],
                    ),
                  ),
                )
              : EmptyData(
                  title: 'No Data'.tr(),
                ),
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<OrderCubit, OrderState>(
              builder: (context, state) => ConstantModel.orderDetailsModel != null && ConstantModel.orderDetailsModel!.data != null
                  ? FloatingActionButton(
                      onPressed: () {
                        if (ConstantModel.orderDetailsModel?.data?.latitude == null || ConstantModel.orderDetailsModel?.data?.longitude == null)
                          return;
                        openGoogleMaps(
                          double.parse(ConstantModel.orderDetailsModel?.data?.latitude ?? '0'),
                          double.parse(ConstantModel.orderDetailsModel?.data?.longitude ?? '0'),
                        ); // Example: San Francisco coordinates
                      },
                      backgroundColor: AppColors.white,
                      child: const Icon(
                        Icons.location_on_rounded,
                        color: AppColors.primaryColor,
                      ),
                    )
                  : const SizedBox(),
            ),
            const SizedBox(
              height: 12,
            ),
            FloatingActionButton(
              onPressed: () {
                context.navigateToPage(MessagesScreen(
                  userId: '${ConstantModel.orderDetailsModel?.data?.clientId ?? 0}',
                  receiverNumber: '${widget.orderData}',
                  techId: '${widget.orderData}',
                ));
              },
              backgroundColor: AppColors.white,
              child: const Icon(
                Icons.headphones,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void openGoogleMaps(double latitude, double longitude) async {
  final String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  final Uri uri = Uri.parse(googleMapsUrl);

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch Google Maps';
  }
}

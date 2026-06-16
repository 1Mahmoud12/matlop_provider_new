import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/component/cache_image.dart';
import 'package:matlop_provider/core/component/camera/preview_page.dart';
import 'package:matlop_provider/core/component/custom_app_bar.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/core/services/video/small_video_widget.dart';
import 'package:matlop_provider/core/services/video/video_player_view.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/core/utils/constants_enum.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/feature/chat/presentation/messages_screen.dart';
import 'package:matlop_provider/feature/home/presentation/widgets/dialog_offer.dart';
import 'package:matlop_provider/feature/home/presentation/widgets/special_order_plan_details.dart';
import 'package:matlop_provider/feature/home/presentation/widgets/special_order_image_widget.dart';
import 'package:matlop_provider/feature/order/presentation/manager/detailsSpecialrderCubit/details_special_order_cubit.dart';
import 'package:matlop_provider/feature/order/presentation/manager/offersCubit/offers_order_cubit.dart';
import 'package:matlop_provider/feature/order/presentation/widgets/custom_stepper_widget.dart';
import 'package:matlop_provider/feature/home/presentation/widgets/special_order_action_btn.dart';
import 'package:matlop_provider/feature/order/presentation/widgets/order_details_view.dart';

class SpecialOrderDetailsView extends StatefulWidget {
  final int idSpecialOrder;
  final OffersOrderCubit? offersOrderCubit;
  final num? offerAmount;
  final bool? submitted;

  const SpecialOrderDetailsView({super.key, required this.idSpecialOrder, this.offersOrderCubit, this.offerAmount, this.submitted});

  @override
  State<SpecialOrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<SpecialOrderDetailsView> {
  late final DetailsSpecialOrderCubit detailsSpecialOrderCubit;

  @override
  void initState() {
    detailsSpecialOrderCubit = DetailsSpecialOrderCubit();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        detailsSpecialOrderCubit.getDetailsSpecialOrderDetails(context, orderId: widget.idSpecialOrder);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        detailsSpecialOrderCubit.getDetailsSpecialOrderDetails(context, orderId: widget.idSpecialOrder);
      },
      backgroundColor: AppColors.scaffoldBackGround,
      color: AppColors.primaryColor,
      child: BlocProvider.value(
        value: detailsSpecialOrderCubit,
        child: Scaffold(
        persistentFooterButtons: [
          SpecialOrderActionBtn(
            offersOrderCubit: widget.offersOrderCubit,
            offerAmount: widget.offerAmount,
            submitted: widget.submitted,
            idSpecialOrder: widget.idSpecialOrder,
          )
        ],
        appBar: CustomAppBar(
          title: 'Order Details'.tr(),
        ),
        body: BlocBuilder<DetailsSpecialOrderCubit, DetailsSpecialOrderState>(
            builder: (context, state) => ConstantModel.detailsSpecialOrderModel != null && ConstantModel.detailsSpecialOrderModel!.data != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          BlocConsumer<DetailsSpecialOrderCubit, DetailsSpecialOrderState>(
                            listener: (context, state) {
                              if (state is ChangeSpecialStatusSuccess) {
                                ConstantModel.detailsSpecialOrderModel!.data!.specialOrderStatus = state.newStatus;
                              }
                            },
                            builder: (context, state) {
                              return state is ChangeSpecialStatusSuccess
                                  ? CustomStepper(selectedStatus: state.newStatus)
                                  : ConstantModel.detailsSpecialOrderModel!.data!.specialOrderStatus!.toInt() < 7
                                      ? CustomStepper(selectedStatus: ConstantModel.detailsSpecialOrderModel!.data!.specialOrderStatus!.toInt())
                                      : const SizedBox();
                            },
                          ),
                          const SizedBox(height: 20),
                          SpecialOrderImageWidget(),
                          Text(
                            'Plan Details'.tr(),
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16.sp),
                          ),
                          const SizedBox(height: 15),
                          SpecialOrderPlanDetails(
                            detailsSpecialOrderModel: ConstantModel.detailsSpecialOrderModel!,
                          ),
                          const SizedBox(height: 15),
                          Text('Order Description'.tr(), style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 15),
                          Container(
                            padding: const EdgeInsets.all(16),
                            alignment: AlignmentDirectional.centerStart,
                            decoration: BoxDecoration(
                              color: AppColors.grey.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.grey.withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              ConstantModel.detailsSpecialOrderModel!.data!.notes ?? Constants.unKnownValue,
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.black.withOpacity(0.4),
                                  ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        // Old commented out footer buttons removed to clean up code
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<DetailsSpecialOrderCubit, DetailsSpecialOrderState>(
              builder: (context, state) => ConstantModel.detailsSpecialOrderModel != null && ConstantModel.detailsSpecialOrderModel!.data != null
                    ? FloatingActionButton(
                        heroTag: 'special_order_location_fab',
                        onPressed: () {
                          final lat = ConstantModel.detailsSpecialOrderModel?.data?.latitude;
                          final lng = ConstantModel.detailsSpecialOrderModel?.data?.longitude;

                          if (lat == null || lng == null) return;
                          if (lat.toString().trim().isEmpty || lng.toString().trim().isEmpty) return;
                          openGoogleMaps(
                            num.parse(ConstantModel.detailsSpecialOrderModel?.data?.latitude != null &&
                                        ConstantModel.detailsSpecialOrderModel?.data?.latitude != ''
                                    ? ConstantModel.detailsSpecialOrderModel!.data!.latitude!
                                    : '0')
                                .toDouble(),
                            num.parse(ConstantModel.detailsSpecialOrderModel?.data?.longitude != null &&
                                        ConstantModel.detailsSpecialOrderModel?.data?.longitude != ''
                                    ? ConstantModel.detailsSpecialOrderModel!.data!.longitude!
                                    : '0')
                                .toDouble(),
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
            if (ConstantModel.detailsSpecialOrderModel?.data?.specialOrderAssigment?.isNotEmpty ?? false)
              FloatingActionButton(
                heroTag: 'special_order_chat_fab',
                onPressed: () {
                  context.navigateToPage(MessagesScreen(
                    userId: '${ConstantModel.detailsSpecialOrderModel?.data?.clientId ?? 0}',
                    receiverNumber: '${userCacheValue?.data?.userId}',
                    techId: '${userCacheValue?.data?.userId ?? 0}',
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
      ),
    );
  }
}

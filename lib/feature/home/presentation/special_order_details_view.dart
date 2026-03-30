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
import 'package:matlop_provider/feature/order/presentation/manager/detailsSpecialrderCubit/details_special_order_cubit.dart';
import 'package:matlop_provider/feature/order/presentation/manager/offersCubit/offers_order_cubit.dart';
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
      child: Scaffold(
        persistentFooterButtons: [
          if (widget.offersOrderCubit != null && userCacheValue?.data?.profile?.technicalType == 4)
            CustomTextButton(
              width: MediaQuery.sizeOf(context).width,
              borderRadius: 16,
              onPress: () {
                widget.offersOrderCubit!.amountController.clear();
                widget.offersOrderCubit!.amountController.text = '${widget.offerAmount ?? ''}';
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: AppColors.scaffoldBackGround,
                  builder: (context) => Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
                    ),
                    child: AddOfferView(
                      cubit: widget.offersOrderCubit!,
                      idSpecialOrder: widget.idSpecialOrder,
                    ),
                  ),
                );
              },
              child: Text(
                (widget.submitted ?? false) ? 'Update Offer'.tr() : 'Add Offer'.tr(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            ),
        ],
        appBar: CustomAppBar(
          title: 'Order Details'.tr(),
        ),
        body: BlocProvider.value(
          value: detailsSpecialOrderCubit,
          child: BlocBuilder<DetailsSpecialOrderCubit, DetailsSpecialOrderState>(
            builder: (context, state) => ConstantModel.detailsSpecialOrderModel != null && ConstantModel.detailsSpecialOrderModel!.data != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          // const CustomStepper(),
                          const SizedBox(height: 20),
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
                              child: SizedBox(
                                height: 60,
                                width: MediaQuery.sizeOf(context).width,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(ConstantModel.detailsSpecialOrderModel!.data!.media?.length ?? 0, (index) {
                                      return InkWell(
                                        onTap: () {
                                          if (ConstantModel.detailsSpecialOrderModel!.data!.media?[index].mediaTypeEnum ==
                                              MediaTypeEnum.Video.index) {
                                            context.navigateToPage(
                                              ChewieDemo(
                                                video: '${EndPoints.domain}${ConstantModel.detailsSpecialOrderModel!.data!.media?[index].src}',
                                              ),
                                            );
                                          } else {
                                            context.navigateToPage(
                                              PreviewPage(
                                                pictureUrl: '${EndPoints.domain}${ConstantModel.detailsSpecialOrderModel!.data!.media?[index].src}',
                                              ),
                                            );
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 5),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: SizedBox(
                                              height: 60,
                                              width: 60,
                                              child: ConstantModel.detailsSpecialOrderModel!.data!.media?[index].mediaTypeEnum ==
                                                      MediaTypeEnum.Video.index
                                                  ? SmallChewieDemo(
                                                      video: '${EndPoints.domain}${ConstantModel.detailsSpecialOrderModel!.data!.media?[index].src}',
                                                    )
                                                  : CacheImage(
                                                      imageUrl:
                                                          '${EndPoints.domain}${ConstantModel.detailsSpecialOrderModel!.data!.media![index].src}',
                                                      height: 60,
                                                      width: 60,
                                                    ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
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
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocProvider.value(
              value: detailsSpecialOrderCubit,
              child: BlocBuilder<DetailsSpecialOrderCubit, DetailsSpecialOrderState>(
                builder: (context, state) => ConstantModel.detailsSpecialOrderModel != null && ConstantModel.detailsSpecialOrderModel!.data != null
                    ? FloatingActionButton(
                        onPressed: () {
                          if (ConstantModel.detailsSpecialOrderModel?.data?.latitude == null ||
                              ConstantModel.detailsSpecialOrderModel?.data?.longitude == null) return;
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
            ),
            const SizedBox(
              height: 12,
            ),
            if (ConstantModel.detailsSpecialOrderModel?.data?.specialOrderAssigment?.isNotEmpty ?? false)
              FloatingActionButton(
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
    );
  }
}

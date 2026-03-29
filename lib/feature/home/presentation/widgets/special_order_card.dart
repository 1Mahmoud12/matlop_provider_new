import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/component/cache_image.dart';
import 'package:matlop_provider/core/component/custom_divider_widget.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/services/video/small_video_widget.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/core/utils/constants_enum.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/feature/home/presentation/special_order_details_view.dart';
import 'package:matlop_provider/feature/home/presentation/widgets/price_and_order_descripiont.dart';
import 'package:matlop_provider/feature/order/data/models/special_orders_model.dart';
import 'package:matlop_provider/feature/order/presentation/manager/offersCubit/offers_order_cubit.dart';

class SpecialOrderCard extends StatelessWidget {
  final ItemSpecialOrder itemSpecialOrder;
  final OffersOrderCubit? offersOrderCubit;

  const SpecialOrderCard({super.key, required this.itemSpecialOrder, this.offersOrderCubit});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.navigateToPage(SpecialOrderDetailsView(
          idSpecialOrder: itemSpecialOrder.specialOrderId!.toInt(),
          offersOrderCubit: offersOrderCubit,
          offerAmount: itemSpecialOrder.offerAmount,
          submitted: itemSpecialOrder.submitted,
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey[200]!,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 3,
                    child: PriceAndOrderDescription(
                      itemSpecialOrder: itemSpecialOrder,
                    )),
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      itemSpecialOrder.specialOrderName ?? Constants.unKnownValue,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.primaryColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const CustomDividerWidget(),
            const SizedBox(
              height: 8,
            ),
            if (itemSpecialOrder.media != null && itemSpecialOrder.media!.isNotEmpty)
              Text('Attachments'.tr(), style: Theme.of(context).textTheme.bodyMedium),
            if (itemSpecialOrder.media != null && itemSpecialOrder.media!.isNotEmpty)
              const SizedBox(
                height: 8,
              ),
            Row(
              children: List.generate(itemSpecialOrder.media?.length ?? 0, (index) {
                return itemSpecialOrder.media?[index].mediaTypeEnum == MediaTypeEnum.Video.index
                    ? SizedBox(
                        width: 60,
                        height: 60,
                        child: SmallChewieDemo(
                          video: '${EndPoints.domain}${itemSpecialOrder.media?[index].src}',
                        ),
                      )
                    : CacheImage(
                        imageUrl: '${EndPoints.domain}${itemSpecialOrder.media![index].src}',
                        width: 60,
                        height: 60,
                      );
              }),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/component/cache_image.dart';
import 'package:matlop_provider/core/component/camera/preview_page.dart';
import 'package:matlop_provider/core/services/video/small_video_widget.dart';
import 'package:matlop_provider/core/services/video/video_player_view.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/utils/constants_enum.dart';
import 'package:matlop_provider/core/utils/navigate.dart';

class SpecialOrderImageWidget extends StatelessWidget {
  const SpecialOrderImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final media = ConstantModel.detailsSpecialOrderModel?.data?.media;
    if (media == null || media.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                  children: List.generate(media.length, (index) {
                    final item = media[index];
                    return InkWell(
                      onTap: () {
                        if (item.mediaTypeEnum == MediaTypeEnum.Video.index) {
                          context.navigateToPage(
                            ChewieDemo(
                              video: item.src,
                            ),
                          );
                        } else {
                          context.navigateToPage(
                            PreviewPage(
                              pictureUrl: item.src,
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
                            child: item.mediaTypeEnum == MediaTypeEnum.Video.index
                                ? SmallChewieDemo(
                                    video: item.src,
                                  )
                                : CacheImage(
                                    imageUrl: item.src,
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
      ],
    );
  }
}

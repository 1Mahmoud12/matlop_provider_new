import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/component/camera/preview_page.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/services/video/small_video_widget.dart';
import 'package:matlop_provider/core/services/video/video_player_view.dart';
import 'package:matlop_provider/core/utils/app_images.dart';
import 'package:matlop_provider/core/utils/constants_enum.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/feature/order/data/models/get_order_details_model.dart';

class MediaList extends StatelessWidget {
  const MediaList({
    super.key,
    required this.mediaList,
  });

  final List<Media> mediaList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: MediaQuery.sizeOf(context).width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(mediaList.length, (index) {
            return InkWell(
              onTap: () {
                if (mediaList[index].mediaTypeEnum == MediaTypeEnum.Video.index) {
                  context.navigateToPage(
                    ChewieDemo(
                      video: '${EndPoints.domain}${mediaList[index].src}',
                    ),
                  );
                } else {
                  context.navigateToPage(
                    PreviewPage(
                      pictureUrl: '${EndPoints.domain}${mediaList[index].src}',
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
                    child: mediaList[index].mediaTypeEnum == MediaTypeEnum.Video.index
                        ? SmallChewieDemo(
                            video: '${EndPoints.domain}${mediaList[index].src}',
                          )
                        : CachedNetworkImage(
                            imageUrl: '${EndPoints.domain}${mediaList[index].src}',
                            placeholder: (context, url) => Image.asset(AppImages.loadingIndicator),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey.withOpacity(0.2),
                              child: const Center(
                                child: Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/feature/chat/data/model/message_model.dart';

class ImageMessage extends StatefulWidget {
  const ImageMessage({
    super.key,
    required this.messageModel,
  });

  final MessageModel messageModel;

  @override
  ImageMessageState createState() => ImageMessageState();
}

class ImageMessageState extends State<ImageMessage> {
  bool _isExpanded = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  String formatTime(String dateTimeString) {
    try {
      final DateTime dateTime = DateTime.parse(dateTimeString);
      return DateFormat.jm().format(dateTime);
    } catch (e) {
      return dateTimeString;
    }
  }

  bool onLongPressIsOn = false;
  bool onTap = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const Row(
        children: [
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
          ),
        ],
      ),
    );
  }
}
  // GestureDetector(
                //   onTap: () => context.navigateToPage(
                //     ShowImage(
                //       imageList: imageList,
                //       text: widget.messageModel.body,
                //     ),
                //   ),
                //   child: ListOfImages(imageList: imageList),
                // ),
                // Row(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     Text(
                //       formatTime(
                //         '${widget.messageModel.createdAt}',
                //       ),
                //       style: Styles.style10400.copyWith(color: AppColors.subTextThinColor),
                //     ),
                //     5.ESW(),
                //     //    SvgPicture.asset(Assets.seenSVG),
                //   ],
                // )

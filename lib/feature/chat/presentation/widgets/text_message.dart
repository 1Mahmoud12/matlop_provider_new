import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/themes/styles.dart';
import 'package:matlop_provider/core/utils/extensions.dart';
import 'package:matlop_provider/feature/chat/data/model/message_model.dart';
import 'package:matlop_provider/feature/chat/presentation/manager/messageCubit/message_cubit.dart';

class TextMessage extends StatefulWidget {
  const TextMessage({
    super.key,
    required this.messageModel,
    this.isFriend = false,
  });

  final MessageModel messageModel;
  final bool isFriend;
  @override
  State<TextMessage> createState() => _TextMessageState();
}

class _TextMessageState extends State<TextMessage> {
  double _dragOffset = 0.0;
  final double _maxSwipeOffset = 100.0;

  @override
  Widget build(BuildContext context) {
    final messageCubit = MessageCubit.of(context);

    return GestureDetector(
      onHorizontalDragUpdate: MessageCubit.of(context).isSelectionModeActive == false
          ? (details) {
              if (details.delta.dx > 0) {
                // Swipe right
                setState(() {
                  _dragOffset += details.delta.dx;
                  if (_dragOffset > _maxSwipeOffset) _dragOffset = _maxSwipeOffset;
                });
              }
            }
          : null,
      onHorizontalDragEnd: (details) {
        if (_dragOffset >= _maxSwipeOffset) {
          MessageCubit.of(context).isSwipedMethod(swipedMessage: widget.messageModel.messageText);
        }
        setState(() {
          _dragOffset = 0.0;
        });
      },
      onLongPress: () {
        log('test 2');
        messageCubit.startSelection(widget.messageModel.id);
      },
      onTap: () {
        log('test 1');

        if (messageCubit.isSelectionModeActive) {
          messageCubit.toggleSelection(widget.messageModel.id);
        }
        setState(() {});
      },
      child: BlocBuilder<MessageCubit, MessageState>(
        buildWhen: (previous, current) => current is MessageLoaded,
        builder: (context, state) {
          final isSelected = messageCubit.isMessageSelected(widget.messageModel.id);
          return Transform.translate(
            offset: Offset(_dragOffset, 0),
            child: Container(
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 5),
              width: MediaQuery.of(context).size.width,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    left: -40,
                    child: Container(
                      color: Colors.transparent,
                      alignment: Alignment.centerLeft,
                      child: const Icon(Icons.reply, color: Colors.blue),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.red.withOpacity(0.4) : Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: widget.isFriend ? MainAxisAlignment.start : MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8).w,
                              constraints: BoxConstraints(maxWidth: context.screenWidth * .7),
                              decoration: BoxDecoration(
                                color: widget.isFriend ? Colors.white : AppColors.primaryColor,
                                borderRadius: widget.isFriend
                                    ? BorderRadius.only(
                                        topLeft: Radius.circular(8.w),
                                        topRight: Radius.circular(8.w),
                                        bottomRight: Radius.circular(8.w),
                                      )
                                    : BorderRadius.only(
                                        topLeft: Radius.circular(8.w),
                                        topRight: Radius.circular(8.w),
                                        bottomLeft: Radius.circular(8.w),
                                      ),
                              ),
                              child: Text(
                                widget.messageModel.messageText,
                                style: Styles.style12400.copyWith(color: widget.isFriend ? Colors.black : AppColors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

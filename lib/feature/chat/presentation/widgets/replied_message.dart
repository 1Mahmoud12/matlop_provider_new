import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/feature/chat/data/model/message_model.dart';
import 'package:matlop_provider/feature/chat/presentation/manager/messageCubit/message_cubit.dart';

class RepliedMessage extends StatefulWidget {
  const RepliedMessage({
    super.key,
    required this.messageModel,
    required this.isFriend,
  });
  final MessageModel messageModel;
  final bool isFriend;
  @override
  State<RepliedMessage> createState() => _RepliedMessageState();
}

class _RepliedMessageState extends State<RepliedMessage> {
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
            child: Stack(
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
                  margin: const EdgeInsets.only(left: 16, right: 16, bottom: 5),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.red.withOpacity(0.4) : Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: widget.isFriend ? MainAxisAlignment.start : MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.withOpacity(0.2)),
                          color: widget.isFriend ? AppColors.white : AppColors.primaryColor,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(12),
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 5,
                                    decoration: BoxDecoration(
                                      color: widget.isFriend ? AppColors.primaryColor : AppColors.white,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                        ),
                                        color: widget.isFriend ? AppColors.primaryColor.withOpacity(0.2) : AppColors.white.withOpacity(0.4),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'You',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(color: widget.isFriend ? AppColors.primaryColor : Colors.white),
                                          ),
                                          const SizedBox(height: 4),
                                          ConstrainedBox(
                                            constraints: const BoxConstraints(minWidth: 100),
                                            child: Text(
                                              widget.messageModel.repliedMessage,
                                              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.textColor),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            ConstrainedBox(
                              constraints: const BoxConstraints(minWidth: 100),
                              child: Text(
                                widget.messageModel.messageText,
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: widget.isFriend ? AppColors.black : Colors.white),
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/feature/chat/presentation/manager/messageCubit/message_cubit.dart';
import 'package:matlop_provider/feature/chat/presentation/widgets/reply_text_field_message.dart';
import 'package:matlop_provider/feature/chat/presentation/widgets/send_message_chat_icon.dart';
import 'package:matlop_provider/feature/chat/presentation/widgets/send_message_text_field.dart';

class ChatTextFieldAndSendIcon extends StatefulWidget {
  final String userId;
  final String techId;

  const ChatTextFieldAndSendIcon({
    super.key,
    required this.userId,
    required this.techId,
  });

  @override
  State<ChatTextFieldAndSendIcon> createState() => _ChatTextFieldAndSendIconState();
}

class _ChatTextFieldAndSendIconState extends State<ChatTextFieldAndSendIcon> {
  @override
  Widget build(BuildContext context) {
    final chatCubit = BlocProvider.of<MessageCubit>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          BlocBuilder<MessageCubit, MessageState>(
            buildWhen: (previous, current) => current is MessageSwiped,
            builder: (context, state) {
              if (state is MessageSwiped && MessageCubit.of(context).isSwiped) {
                return Expanded(
                  flex: 5,
                  child: ReplyTextFieldMessage(
                    controller: MessageCubit.of(context).sendReplyController,
                    onTapAttachment: () {
                      showAttachmentOptions(context, chatCubit, userId: widget.userId);
                    },
                  ),
                );
              } else {
                return Expanded(
                  flex: 5,
                  child: SendMessageTextField(
                    controller: MessageCubit.of(context).sendController,
                    onTapAttachment: () {
                      showAttachmentOptions(context, chatCubit, userId: widget.userId);
                    },
                  ),
                );
              }
            },
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              MessageCubit.of(context).onSendIcon(userId: widget.userId, techId: widget.techId);
            },
            child: const SendMessageChatIcon(),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}

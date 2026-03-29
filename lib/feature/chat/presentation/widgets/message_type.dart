import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/feature/chat/data/model/message_model.dart';
import 'package:matlop_provider/feature/chat/presentation/widgets/replied_message.dart';
import 'package:matlop_provider/feature/chat/presentation/widgets/text_message.dart';

class MessageType extends StatelessWidget {
  const MessageType({super.key, required this.messageModel});
  final MessageModel messageModel;
  @override
  Widget build(BuildContext context) {
    final isReplied = messageModel.isReplied;
    if (isReplied) {
      return RepliedMessage(
        messageModel: messageModel,
        isFriend: messageModel.receiverNumber == Constants.serviceNumber,
      );
    } else {
      log('test replied message!!');
      return TextMessage(
        messageModel: messageModel,
        isFriend: messageModel.receiverNumber == Constants.serviceNumber,
      );
    }
  }
}

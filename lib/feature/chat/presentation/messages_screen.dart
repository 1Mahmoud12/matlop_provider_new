import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/custom_app_bar.dart';
import 'package:matlop_provider/core/component/loading_widget.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/feature/chat/presentation/widgets/chat_text_field_and_sendicon.dart';
import 'package:matlop_provider/feature/chat/presentation/widgets/delete_message_icon.dart';
import 'package:matlop_provider/feature/chat/presentation/widgets/message_type.dart';

import 'manager/messageCubit/message_cubit.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key, required this.userId, required this.receiverNumber, required this.techId});

  final String userId;
  final String techId;
  final String receiverNumber;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  void initState() {
    super.initState();
    MessageCubit.of(context).getMessages(useId: widget.userId, techId: widget.techId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Chat'.tr(),
        widget: BlocBuilder<MessageCubit, MessageState>(
          builder: (context, state) {
            if (state is MessageLoaded && state.isSelectionModeActive) {
              return DeleteMessageIcon(
                userId: widget.userId,
              );
            }
            return const SizedBox();
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: AppColors.primaryColor.withOpacity(0.1),
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
          ),
          Column(
            children: [
              //  const UserDataAndSearchBar(),
              Expanded(
                child: BlocBuilder<MessageCubit, MessageState>(
                  buildWhen: (previous, current) => current is MessageLoaded || current is LoadingMessages,
                  builder: (context, state) {
                    if (MessageCubit.of(context).messagesList.isNotEmpty) {
                      return ListView.builder(
                        controller: MessageCubit.of(context).scrollController,
                        reverse: true,
                        itemCount: MessageCubit.of(context).messagesList.length,
                        itemBuilder: (context, index) {
                          return MessageType(
                            messageModel: MessageCubit.of(context).messagesList[index],
                          );
                        },
                      );
                    }
                    if (state is LoadingMessages) return const LoadingWidget();
                    return const SizedBox();
                  },
                ),
              ),
              ChatTextFieldAndSendIcon(
                userId: widget.userId,
                techId: widget.techId,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}

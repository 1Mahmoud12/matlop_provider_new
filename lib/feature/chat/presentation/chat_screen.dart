import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/themes/styles.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/feature/chat/presentation/manager/messageCubit/message_cubit.dart';
import 'package:matlop_provider/feature/chat/presentation/widgets/chat_item.dart';
import 'package:matlop_provider/feature/chat/presentation/widgets/chat_not_available_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch chats when the screen is initialized
    context.read<MessageCubit>().getAllChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Chats'.tr(),
              style: Styles.style20700.copyWith(color: AppColors.black),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<MessageCubit, MessageState>(
                buildWhen: (previous, current) => current is LoadingChats || current is ChatsError || current is ChatLoaded,
                builder: (context, state) {
                  if (state is LoadingChats) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ChatLoaded) {
                    if (state.chatList.isEmpty) {
                      return const Center(child: Text('No chats available'));
                    }
                    return Constants.serviceNumber == userCacheValue?.data?.mobileNumber
                        ? ListView.builder(
                            itemCount: state.chatList.length,
                            itemBuilder: (context, index) {
                              final chat = state.chatList[index];
                              return ChatItem(
                                userId: chat.userId,
                                name: chat.senderName, // Assuming you want to show the receiver's name
                                lastMessage: chat.lastMessage, // Assuming you want to show the receiver's phone number
                              );
                            },
                          )
                        : const ChatNotAvailableWidget();
                  } else if (state is ChatsError) {
                    return Center(child: Text('Error: ${state.e}'));
                  }
                  return const Center(child: Text('Something went wrong'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

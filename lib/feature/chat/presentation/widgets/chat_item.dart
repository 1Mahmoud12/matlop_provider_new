import 'package:flutter/material.dart';
import 'package:matlop_provider/core/utils/app_images.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/feature/chat/presentation/messages_screen.dart';

class ChatItem extends StatelessWidget {
  final String userId;
  final String name;
  final String lastMessage;

  const ChatItem({
    super.key,
    required this.userId,
    required this.name,
    required this.lastMessage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the MessagesScreen with the chatId
        context.navigateToPage(MessagesScreen(
          userId: userId,
          receiverNumber: lastMessage,
          techId: '0',
        ));
      },
      child: Container(
        height: 80,
        width: MediaQuery.sizeOf(context).width,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.grey.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Colors.amber,
                ),
                child: Image.asset(
                  AppImages.unknownUserImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    lastMessage,
                    style: const TextStyle(
                      color: Colors.grey,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

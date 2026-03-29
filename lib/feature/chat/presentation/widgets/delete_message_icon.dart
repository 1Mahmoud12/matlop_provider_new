import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/loading_widget.dart';
import 'package:matlop_provider/feature/chat/presentation/manager/messageCubit/message_cubit.dart';

class DeleteMessageIcon extends StatelessWidget {
  const DeleteMessageIcon({super.key, required this.userId});
  final String userId;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            final messageCubit = MessageCubit.of(context);
            return BlocBuilder<MessageCubit, MessageState>(
              buildWhen: (previous, current) => current is MessageDeletingLoading,
              builder: (context, state) {
                if (state is MessageDeletingLoading) {
                  return const PopScope(
                    canPop: false,
                    child: AlertDialog(
                      title: Text('Deleting Messages'),
                      content: SizedBox(
                        height: 50,
                        child: LoadingWidget(),
                      ),
                    ),
                  );
                }
                return AlertDialog(
                  title: const Text('Delete Messages'),
                  content: const Text(
                    'Are you sure you want to delete selected messages?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        messageCubit.deleteSelectedMessages(context: context, userId: userId);
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}

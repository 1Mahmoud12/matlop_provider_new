part of 'message_cubit.dart';

sealed class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageInitial extends MessageState {}
class LoadingChats extends MessageState {}

class MessageDeletingLoading extends MessageState {}

class MessageSentSuccess extends MessageState {}

class MessageLoaded extends MessageState {
  final List<MessageModel> messageList;
  final bool isSelectionModeActive;

  const MessageLoaded({
    required this.messageList,
    this.isSelectionModeActive = false,
  });

  @override
  List<Object> get props => [messageList, isSelectionModeActive];
}

class MessageIsSelected extends MessageState {
  final String messageId;
  final bool isSelected;

  const MessageIsSelected({
    required this.messageId,
    required this.isSelected,
  });

  @override
  List<Object> get props => [messageId, isSelected];
}

class MessageError extends MessageState {
  final String e;

  const MessageError({required this.e});

  @override
  List<Object> get props => [e];
}
class ChatsError extends MessageState {
  final String e;

  const ChatsError({required this.e});

  @override
  List<Object> get props => [e];
}

class MessageDeleteSuccess extends MessageState {
  @override
  List<Object> get props => [];
}

class MessageSwiped extends MessageState {
  final bool isSwiped;
  final String swipedMessage;
  const MessageSwiped({
    required this.isSwiped,
    required this.swipedMessage,
  });

  @override
  List<Object> get props => [isSwiped, swipedMessage];
}

class LoadingMessages extends MessageState {}
class ChatLoaded extends MessageState {
  final List<ChatModel> chatList;

  const ChatLoaded({
    required this.chatList,
  });

  @override
  List<Object> get props => [chatList];
}
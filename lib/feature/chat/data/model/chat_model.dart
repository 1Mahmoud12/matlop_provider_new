
class ChatModel {
  final String userId;
  final String senderName;
  final String senderNumber;
  final String lastMessage;
  final String lastMessageTime;


  ChatModel({
    required this.userId,
    required this.senderName,
    required this.senderNumber,
    required this.lastMessage,
    required this.lastMessageTime,

  });

  factory ChatModel.fromMap(String userId, Map<String, dynamic> data) {
    return ChatModel(
      userId: userId,
      senderName: data['senderName'] ?? '',
      senderNumber: data['senderNumber'] ?? '',
      lastMessage: data['lastMessage'] ?? '',
      lastMessageTime: data['lastMessageTime'] ?? '',
    );
  }
}





class MessageModel {
  final String id; // Firestore document ID
  final String senderNumber;
  final String receiverNumber;
  final String messageText;
  final String createdAt;
  final bool isReplied;
  final String repliedMessage;
  final String imageUrl;

  MessageModel({
    required this.id,
    required this.senderNumber,
    required this.receiverNumber,
    required this.messageText,
    required this.createdAt,
    required this.isReplied,
    required this.repliedMessage,
    required this.imageUrl,
  });

  // Factory method to create a MessageModel from Firestore document data
  factory MessageModel.fromMap(String id, Map<String, dynamic> map) {
    return MessageModel(
      id: id, // Use Firestore-generated document ID
      senderNumber: map['senderNumber'] ?? '',
      receiverNumber: map['receiverNumber'] ?? '',
      messageText: map['messageText'] ?? '',
      createdAt:map['created_at'].toString(),
      repliedMessage: map['repliedMessage'] ?? '',
      isReplied: map['isReplied'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  // Method to convert a MessageModel to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'senderNumber': senderNumber,
      'receiverNumber': receiverNumber,
      'messageText': messageText,
      'created_at': createdAt,
      'repliedMessage': repliedMessage,
      'isReplied': isReplied,
      'imageUrl': imageUrl,
    };
  }
}

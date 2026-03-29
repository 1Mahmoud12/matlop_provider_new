import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/feature/chat/data/model/chat_model.dart';
import 'package:matlop_provider/feature/chat/data/model/message_model.dart';
import 'package:matlop_provider/feature/chat/presentation/widgets/image_preview_screen.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(MessageInitial());

  static MessageCubit of(BuildContext context) => BlocProvider.of<MessageCubit>(context);

  final TextEditingController sendController = TextEditingController();
  final TextEditingController sendReplyController = TextEditingController();
  final CollectionReference messagesCollection = FirebaseFirestore.instance.collection('messages');
  final ScrollController scrollController = ScrollController();
  String repliedMessage = '';
  bool isReplied = false;
  final Set<String> selectedMessages = {};
  bool isSelectionModeActive = false;
  List<MessageModel> messagesList = [];

  bool isSwiped = false;

  File? selectedImage;

  void pickImage(BuildContext context, {required String userId}) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.isNotEmpty) {
      final String? imagePath = result.files.single.path;

      if (imagePath != null) {
        selectedImage = File(imagePath);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImagePreviewScreen(
              selectedImage: [selectedImage!],
              userId: userId,
              techId: '0',
            ),
          ),
        );

        // Return the path of the selected image
        //  return selectedImage.path;
      }
    } else {
      // Handle the case where no file was selected or the result is null
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected.')),
      );
    }

    // Return null if no image was selected
    return null;
  }

  void isSwipedMethod({required String swipedMessage}) {
    if (isSelectionModeActive == false) {
      repliedMessage = swipedMessage;
      isSwiped = true;
      log('isSwiped===$isSwiped');
      emit(
        MessageSwiped(
          swipedMessage: repliedMessage,
          isSwiped: isSwiped,
        ),
      );
    }
  }

  Future<String?> uploadImageToFirebase(File imageFile) async {
    try {
      // Create a unique file name for the image
      final String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // Create a reference to the Firebase Storage
      final Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('chat_images').child(fileName);

      // Upload the image file
      final UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
      final TaskSnapshot taskSnapshot = await uploadTask;

      // Get the download URL of the uploaded image
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      log('Error uploading image: $e');
      return null;
    }
  }

  void closeIsSwiped() {
    if (isSelectionModeActive == false) {
      isSwiped = false;
      log('isSwiped===$isSwiped');
      emit(
        MessageSwiped(
          swipedMessage: '',
          isSwiped: isSwiped,
        ),
      );
    }
  }

  /// Check if a message is selected
  bool isMessageSelected(String id) => selectedMessages.contains(id);

  /// Start selection mode and select the first message
  void startSelection(String id) {
    debugPrint('Start selection: $id');
    if (!isSelectionModeActive) {
      isSelectionModeActive = true;
    }
    selectedMessages.add(id);

    emit(
      MessageLoaded(
        messageList: List.from(
          messagesList,
        ),
        isSelectionModeActive: isSelectionModeActive,
      ),
    );
    // emitSelectionState();
  }

  void toggleSelection(String id) {
    if (selectedMessages.contains(id)) {
      selectedMessages.remove(id);
    } else {
      selectedMessages.add(id);
    }

    // Exit selection mode if no messages remain selected
    if (selectedMessages.isEmpty) {
      isSelectionModeActive = false;
    }

    debugPrint('Toggle selection: $id, Current Selected: $selectedMessages');
    emit(
      MessageLoaded(
        messageList: List.from(
          messagesList,
        ),
        isSelectionModeActive: isSelectionModeActive,
      ),
    );
  }

  // handel send message icon=
  void onSendIcon({required String userId, required String techId}) async {
    final messageText = sendController.text.trim();
    final replyMessageText = sendReplyController.text.trim();

    if (messageText.isNotEmpty || replyMessageText.isNotEmpty) {
      if (isSwiped) {
        sendMessage(
          userId: userId,
          techId: techId,
          senderNumber: Constants.serviceNumber,
          receiverNumber: 'Tech',
          messageText: repliedMessage,
          repliedMessage: replyMessageText,
          isReplied: true,
          imageUrl: '',
          senderName: '${userCacheValue?.data?.name}',
        );
        closeIsSwiped();
      } else {
        sendMessage(
          userId: userId,
          techId: techId,
          senderNumber: Constants.serviceNumber,
          receiverNumber: '123',
          messageText: messageText.isNotEmpty ? messageText : '',
          repliedMessage: '',
          isReplied: false,
          imageUrl: '',
          senderName: '${userCacheValue?.data?.name}',
        );
      }
    }
    sendController.clear();
    sendReplyController.clear();
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  /// Clear all selected messages and exit selection mode
  void clearSelection() {
    selectedMessages.clear();
    isSelectionModeActive = false;
    emitSelectionState();
  }

  /// Emit updated state when selection changes
  void emitSelectionState() {
    if (state is MessageLoaded) {
      final currentState = state as MessageLoaded;

      emit(
        MessageLoaded(
          messageList: List.from(currentState.messageList), // Clone the list to ensure immutability
          isSelectionModeActive: isSelectionModeActive,
        ),
      );
    }
  }

  void deleteSelectedMessages({
    required BuildContext context,
    required String userId, // chatId to identify which chat's messages to delete
  }) async {
    try {
      // Start loading state
      emit(MessageDeletingLoading());

      // Check if there are any selected messages to delete
      if (selectedMessages.isEmpty) {
        Navigator.pop(context);
        emit(const MessageError(e: 'No messages selected for deletion.'));
        return;
      }

      // Loop through each selected message and delete it from the messages subcollection
      for (final String messageId in selectedMessages) {
        await chatsCollection
            .doc(userId) // Access the specific chat document by its chatId
            .collection('messages') // Access the messages subcollection
            .doc(messageId) // Access the specific message by its messageId
            .delete(); // Delete the message
      }

      // Clear the selection after successful deletion
      clearSelection();

      // Close the dialog or screen after deletion
      Navigator.pop(context);

      // Emit success state after deletion and clearing selection
      emitSelectionState();
    } catch (e) {
      // If there is an error, pop the dialog and emit an error state
      Navigator.pop(context);
      emit(MessageError(e: e.toString()));
    }
  }

  /// Send a message to Firestore
  final CollectionReference chatsCollection = FirebaseFirestore.instance.collection('chats');

  Future<void> sendMessage({
    required String userId, // chatId to identify the chat between users
    required String techId, // chatId to identify the chat between users
    required String senderNumber,
    required String senderName,
    required String receiverNumber,
    required String messageText,
    required String repliedMessage,
    required bool isReplied,
    required String imageUrl,
  }) async {
    try {
      // Check if chat already exists, if not create or update with user details
      final chatDoc = chatsCollection.doc(userId);
      final chatSnapshot = await chatDoc.get();

      if (!chatSnapshot.exists) {
        // If chat does not exist, create it with the user details
        if (techId == '0') {
          await chatDoc.set({
            'userId': userId,
            'senderName': senderName,
            'senderNumber': senderNumber,
            'lastMessage': messageText,
            'lastMessageTime': DateTime.now().toString(),
          });
        }
        // Add the message to the 'messages' subcollection of the chat document
        await chatDoc.collection('chats').doc(techId).collection('messages').add({
          'senderNumber': senderNumber,
          'receiverNumber': receiverNumber,
          'messageText': messageText,
          'created_at': FieldValue.serverTimestamp(),
          'repliedMessage': repliedMessage,
          'isReplied': isReplied,
          'imageUrl': imageUrl,
        });
      } else {
        // Add the message to the 'messages' subcollection of the chat document
        await chatDoc.collection('chats').doc(techId).collection('messages').add({
          'senderNumber': senderNumber,
          'receiverNumber': receiverNumber,
          'messageText': messageText,
          'created_at': FieldValue.serverTimestamp(),
          'repliedMessage': repliedMessage,
          'isReplied': isReplied,
          'imageUrl': imageUrl,
        });
        // If chat exists, update the last message and timestamp
        if (techId == '0') {
          await chatDoc.update({
            'lastMessage': messageText,
            'lastMessageTime': FieldValue.serverTimestamp().toString(),
          });
        }
      }

      //emit(MessageSentSuccess());
    } catch (e) {
      //emit(MessageError(error: e.toString()));
      log('Error sending message: $e');
    }
  }

  /// Listen for message updates from Firestore
  void getMessages({
    required String useId, // Use chatId to fetch messages from a specific chat
    required String techId, // Use chatId to fetch messages from a specific chat
  }) {
    emit(LoadingMessages());
    try {
      // Access the 'messages' subcollection inside the specific chat document
      chatsCollection
          .doc(useId) // Get the chat document by chatId
          .collection('chats')
          .doc(techId) // Access the 'messages' subcollection
          .collection('messages') // Access the 'messages' subcollection
          .orderBy('created_at', descending: true) // Order messages by the created timestamp
          .snapshots()
          .listen((event) {
        messagesList.clear();
        final newMessages = event.docs.map((doc) {
          final data = doc.data(); // Explicit cast
          return MessageModel.fromMap(doc.id, data); // Convert the document into your MessageModel
        }).toList();
        messagesList = newMessages;

        emit(
          MessageLoaded(
            messageList: messagesList,
            isSelectionModeActive: isSelectionModeActive,
          ),
        );
      });
    } catch (e) {
      log('Exception while getting messages: $e');

      /// emit(MessageError(e: e.toString()));
    }
  }

// get all available chats

  void getAllChats() {
    emit(LoadingChats());
    try {
      // Fetch all chat documents from the 'chats' collection
      chatsCollection.snapshots().listen((event) {
        List<ChatModel> chatsList = [];
        final newChats = event.docs.map((doc) {
          final data = doc.data()! as Map<String, dynamic>; // Explicit cast
          return ChatModel.fromMap(doc.id, data); // Convert the document into your ChatModel
        }).toList();
        chatsList = newChats;

        // Emit a successful state with the list of chats
        emit(ChatLoaded(chatList: chatsList));
      });
    } catch (e) {
      log('Exception while getting chats: $e');
      emit(ChatsError(e: e.toString()));
    }
  }

  /// Dispose resources (optional, if needed)
  void dispose() {
    sendController.dispose();
    super.close();
  }
}

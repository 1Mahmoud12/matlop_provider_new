// import 'package:cool_dropdown/cool_dropdown.dart';
// import 'package:cool_dropdown/models/cool_dropdown_item.dart';
// import 'package:flutter/material.dart';
// import 'package:tashiraa/core/utils/extensions.dart';
// import 'package:tashiraa/features/chat/data/model/model_message.dart';
// import 'package:tashiraa/features/chat/presentation/manager/chat_cubit.dart';

// Widget showBar({
//   required BuildContext context,
//   required List<MessageModelFirebase> message,
//   required int index,
//   required String id,
//   required String code,
//   required String classId,
//   required String idStudent,
//   required String nameStudent,
//   required String text,
//   required bool send,
//   required FocusNode focusNode,
// }) {
//   //['Delete', 'Reply', 'Forward'] : ['Reply', 'Forward'];

//   final List<CoolDropdownItem> items = send
//       ? [
//           CoolDropdownItem<String>(
//             label: 'Delete',
//             value: 'Delete',
//           ),
//           CoolDropdownItem<String>(label: 'Reply', value: 'Reply'),
//           CoolDropdownItem<String>(label: 'Forward', value: 'Forward'),
//         ]
//       : [
//           CoolDropdownItem<String>(label: 'Reply', value: 'Reply'),
//           CoolDropdownItem<String>(label: 'Forward', value: 'Forward'),
//         ];
//   final DropdownController dropdownController = DropdownController();
//   return CoolDropdown(
//     dropdownList: items,
//     onChange: (p0) async => p0 == 'Delete'
//         ? {
//             dropdownController.close(),
//             message.removeAt(index),
//             ChatCubit.of(context).deleteDocument(
//               subjectId: id,
//               code: code,
//               classId: classId,
//               documentId: 'ChatCubit.of(context).messageId[subject.id.toString()]!.reversed.toList()[index]',
//             ),
//             //Navigator.pop(context),
//           }
//         : p0 == 'Reply'
//             ? {
//                 dropdownController.close(),
//                 // bool reply
//                 // new message with that bool
//                 // FocusScope.of(context).requestFocus(_focusNode),
//                 ChatCubit.of(context).wilReply = true,
//                 ChatCubit.of(context).replayedMessage = message[index],
//                 //Navigator.pop(context),
//                 focusNode.requestFocus(),
//                 ChatCubit.of(context).changeState(),
//                 /* await ChatCubit.of(context).createMessageChatsRemoteDataSource({
//                                                   'id': id.toString(),
//                                                   'memberId': idStudent,
//                                                   'studentName': nameStudent,
//                                                   'reply': ChatCubit.of(context).messageId!.reversed.toList()[index],
//                                                   'classId': classId.toString(),
//                                                   'code': code,
//                                                   'text': text,
//                                                   'dateTime': DateTime.now().toString(),
//                                                   'createdAt': DateTime.now(),
//                                                 })*/
//               }
//             : {
//                 dropdownController.close(),
//                 //Navigator.pop(context),
//               },
//     controller: dropdownController,
//     dropdownOptions: DropdownOptions(
//       borderSide: const BorderSide(),
//       width: context.screenWidth * .2,
//     ),
//     resultOptions: ResultOptions(
//       width: context.screenWidth * .1,
//       render: ResultRender.icon,
//       padding: EdgeInsets.zero,
//       icon: const Icon(Icons.more_vert),
//       mainAxisAlignment: MainAxisAlignment.center,
//     ),
//     dropdownItemOptions: DropdownItemOptions(
//       render: DropdownItemRender.label,
//       selectedPadding: EdgeInsets.zero,
//       padding: EdgeInsets.zero,
//       isMarquee: true,
//       alignment: Alignment.centerRight,
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       selectedBoxDecoration: BoxDecoration(
//         border: Border(
//           left: BorderSide(
//             color: Colors.black.withOpacity(0.7),
//             width: 3,
//           ),
//         ),
//       ),
//     ),
//   );

//   /*showDialog(
//     context: context,
//     builder: (context) {
//       double heightMedia = MediaQuery.sizeOf(context).height;
//       double widthMedia = MediaQuery.sizeOf(context).width;
//       focusNode.unfocus();
//       return GestureDetector(
//         onTapDown: (details) {
//           // Get the size of the widget
//           // Print position along with width and height
//           printDM('Tapped at: ${details.globalPosition}');
//           if (details.globalPosition.dx < heightMedia * .25 ||
//               details.globalPosition.dx > heightMedia * .75 ||
//               details.globalPosition.dy < widthMedia * .25 ||
//               details.globalPosition.dy < widthMedia * .75) {
//             Navigator.pop(context);
//           }
//         },
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           resizeToAvoidBottomInset: true,
//           body: Container(
//             decoration: BoxDecoration(
//               color: Colors.transparent,
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 MessageWidget(
//                     send: send,
//                     message: message,
//                     index: index,
//                     subject: subject,
//                     idStudent: idStudent,
//                     nameStudent: nameStudent,
//                     text: text,
//                     showDialogBool: false,
//                     focusNode: focusNode),
//                 20.sizedBoxHeight,
//                 Row(
//                   mainAxisAlignment: send ? MainAxisAlignment.start : MainAxisAlignment.end,
//                   children: [
//                     Container(
//                       width: MediaQuery.sizeOf(context).width * .5,
//                       margin: EdgeInsets.only(left: MediaQuery.sizeOf(context).width * .04),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                         color: Colors.white,
//                       ),
//                       child: Column(
//                         children: items
//                             .map((e) => Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     TextButton(
//                                       child: Container(
//                                         color: Colors.white,
//                                         width: MediaQuery.sizeOf(context).width * .5,
//                                         child: Text(
//                                           e,
//                                         ),
//                                       ),
//                                       onPressed: () async => e == 'Delete'
//                                           ? {
//                                               message.removeAt(index),
//                                               ChatCubit.of(context).deleteDocument(
//                                                   subjectId: id.toString(),
//                                                   code: code,
//                                                   classId: classId.toString(),
//                                                   documentId: ChatCubit.of(context).messageId[subject.id.toString()]!.reversed.toList()[index]),
//                                               Navigator.pop(context),
//                                             }
//                                           : e == 'Reply'
//                                               ? {
//                                                   // bool reply
//                                                   // new message with that bool
//                                                   // FocusScope.of(context).requestFocus(_focusNode),
//                                                   ChatCubit.of(context).wilReply = true,
//                                                   ChatCubit.of(context).replayedMessage = message[index],
//                                                   Navigator.pop(context),
//                                                   focusNode.requestFocus(),
//                                                   ChatCubit.of(context).changeState(),
//                                                   */ /* await ChatCubit.of(context).createMessageChatsRemoteDataSource({
//                                                   'id': id.toString(),
//                                                   'memberId': idStudent,
//                                                   'studentName': nameStudent,
//                                                   'reply': ChatCubit.of(context).messageId!.reversed.toList()[index],
//                                                   'classId': classId.toString(),
//                                                   'code': code,
//                                                   'text': text,
//                                                   'dateTime': DateTime.now().toString(),
//                                                   'createdAt': DateTime.now(),
//                                                 })*/ /*
//                                                 }
//                                               : {Navigator.pop(context), showBottomSheetCustom(context: context, message: message[index])},
//                                     ),
//                                     const Divider(
//                                       color: Colors.black,
//                                     )
//                                   ],
//                                 ))
//                             .toList(),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );*/
// }

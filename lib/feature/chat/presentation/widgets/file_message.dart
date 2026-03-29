// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:user_workers/core/themes/colors.dart';
// import 'package:user_workers/core/themes/styles.dart';
// import 'package:user_workers/core/utils/screen_spaces_extension.dart';
// import 'package:user_workers/features/chat/presentation/manager/chat_cubit.dart';
// import 'package:user_workers/features/chat/presentation/widgets/seemore_seeless_widget.dart';

// class FileMessage extends StatefulWidget {
//   const FileMessage({
//     super.key,
//     required this.context,
//     required this.fileName,
//     this.text,
//     required this.message,
//     this.isComingMessage,
//     required this.chatId,
//   });

//   final BuildContext context;
//   final String? fileName;
//   final String? text;
//   final MessageModelFirebase message;
//   final String chatId;
//   final bool? isComingMessage;

//   @override
//   State<FileMessage> createState() => _FileMessageState();
// }

// class _FileMessageState extends State<FileMessage> {
//   bool _isExpanded = false;

//   void _toggleExpand() {
//     setState(() {
//       _isExpanded = !_isExpanded;
//     });
//   }

//   Future<void> _launchUrl() async {
//     if (!await launchUrl(Uri.parse(widget.message.file))) {
//       throw Exception('Could not launch');
//     }
//   }

//   String formatTime(String dateTimeString) {
//     try {
//       final DateTime dateTime = DateTime.parse(dateTimeString);
//       return DateFormat.jm().format(dateTime);
//     } catch (e) {
//       return dateTimeString;
//     }
//   }

//   // Extract the file name from the fileUrl
//   String fetchFileName() {
//     String fileName = '';

//     final uri = Uri.parse(widget.message.file);
//     fileName = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : 'Unknown File';
//     if (fileName.startsWith('files/')) {
//       fileName = fileName.substring('files/'.length);
//     }

//     return fileName;
//   }

//   bool onLongPressIsOn = false;
//   bool onTap = false;
//   @override
//   Widget build(BuildContext context) {
//     final chatCubit = BlocProvider.of<ChatCubit>(context);

//     return GestureDetector(
//       onLongPress: () async {
//         HapticFeedback.vibrate();
//         if (onLongPressIsOn) {
//           await chatCubit.updateMessageSelection(widget.message.id, '', widget.chatId);
//           chatCubit.selectedMessagesList.remove(widget.message.id);
//           // chatCubit.favoriteMessages.remove(widget.messageId);
//         } else {
//           await chatCubit.updateMessageSelection(
//             widget.message.id,
//             'isSelected',
//             widget.chatId,
//           );
//           chatCubit.selectedMessagesList.add(widget.message.id);
//           // if (widget.message.isFavorite!.isEmpty) {
//           //   chatCubit.favoriteMessages.add(widget.messageId);
//           // }
//         }
//         setState(() {
//           onLongPressIsOn = !onLongPressIsOn;
//         });
//       },
//       onTap: chatCubit.selectedMessagesList.isNotEmpty
//           ? () async {
//               if (onTap || widget.message.isSelected.isNotEmpty) {
//                 await chatCubit.updateMessageSelection(
//                   widget.message.id,
//                   '',
//                   widget.chatId,
//                 );
//                 chatCubit.selectedMessagesList.remove(widget.message.id);
//                 //chatCubit.favoriteMessages.remove(widget.messageId);
//               } else {
//                 await chatCubit.updateMessageSelection(
//                   widget.message.id,
//                   'isSelected',
//                   widget.chatId,
//                 );
//                 chatCubit.selectedMessagesList.add(widget.message.id);
//                 // if (widget.message.isFavorite!.isEmpty) {
//                 //   chatCubit.favoriteMessages.add(widget.messageId);
//                 // }
//               }
//               setState(() {
//                 onTap = !onTap;
//               });
//             }
//           : null,
//       child: Container(
//         decoration: BoxDecoration(
//           color: widget.message.isSelected.isNotEmpty ? chatCubit.selectionColor : Colors.transparent,
//           borderRadius: BorderRadius.circular(5),
//         ),
//         child: Row(
//           children: [
//             const Spacer(),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     _launchUrl();
//                   },
//                   child: Container(
//                     padding: EdgeInsets.only(bottom: widget.message.message.isEmpty ? 10 : 5),
//                     width: MediaQuery.of(context).size.width * 0.8,
//                     decoration: BoxDecoration(
//                       color: widget.isComingMessage != null ? const Color(0xffF2F4F5) : AppColors.primaryColor,
//                       borderRadius: widget.isComingMessage != null
//                           ? context.locale.languageCode == 'ar'
//                               ? const BorderRadius.only(
//                                   topLeft: Radius.circular(10),
//                                   bottomRight: Radius.circular(10),
//                                   bottomLeft: Radius.circular(10),
//                                 )
//                               : const BorderRadius.only(
//                                   topRight: Radius.circular(10),
//                                   bottomRight: Radius.circular(10),
//                                   bottomLeft: Radius.circular(10),
//                                 )
//                           : context.locale.languageCode == 'ar'
//                               ? const BorderRadius.only(
//                                   topLeft: Radius.circular(10),
//                                   topRight: Radius.circular(10),
//                                   bottomRight: Radius.circular(10),
//                                 )
//                               : const BorderRadius.only(
//                                   topLeft: Radius.circular(10),
//                                   topRight: Radius.circular(10),
//                                   bottomLeft: Radius.circular(10),
//                                 ),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         if (widget.message.message != '')
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                             child: SeeMoreSeeLessWidget(
//                               color: widget.isComingMessage != null ? Colors.black : null,
//                               text: widget.message.message,
//                               isExpanded: _isExpanded,
//                               onTap: _toggleExpand,
//                             ),
//                           ),
//                         Container(
//                           height: 50,
//                           margin: EdgeInsets.only(
//                             left: 20,
//                             right: 20,
//                             bottom: 10,
//                             top: widget.message.message == '' ? 20 : 0,
//                           ),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: Colors.white,
//                           ),
//                           child: Row(
//                             children: [
//                               const Padding(
//                                 padding: EdgeInsets.only(left: 16, right: 5),
//                                 //   child: SvgPicture.asset(Assets.linkIcon),
//                               ),
//                               Expanded(
//                                 flex: 4,
//                                 child: Text(
//                                   fetchFileName(),
//                                   style: Styles.style12500,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                               // const Spacer(),
//                               // VerticalDivider(
//                               //   thickness: 0.5,
//                               //   color: Colors.grey.withOpacity(0.5),
//                               // ),
//                               // Padding(
//                               //   padding: const EdgeInsets.only(left: 6, right: 16),
//                               //   child: SvgPicture.asset(Assets.downloadIcon),
//                               // ),
//                             ],
//                           ),
//                         ),
//                         // Row(
//                         //   mainAxisAlignment: MainAxisAlignment.end,
//                         //   children: [
//                         //     Padding(
//                         //       padding: const EdgeInsets.only(top: 5, right: 5, bottom: 5),
//                         //       child: Text(
//                         //         formatTime(
//                         //           widget.message.createdAt,
//                         //         ),
//                         //         style: Styles.style10400.copyWith(color: const Color(0xffD3D3D3)),
//                         //       ),
//                         //     ),

//                         //   ],
//                         // ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       formatTime(
//                         widget.message.createdAt,
//                       ),
//                       style: Styles.style10400.copyWith(color: AppColors.subTextThinColor),
//                     ),
//                     5.ESW(),
//                     //   SvgPicture.asset(Assets.seenSVG),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:user_workers/core/themes/colors.dart';
// import 'package:user_workers/core/themes/styles.dart';
// import 'package:user_workers/core/utils/navigate.dart';
// import 'package:user_workers/features/chat/presentation/messages_screen.dart';

// class ItemChatWidget extends StatefulWidget {
//   const ItemChatWidget({super.key, required this.conversationData, required this.uuid});
//   final String uuid;
//   final ConversationData conversationData;

//   @override
//   State<ItemChatWidget> createState() => _ItemChatWidgetState();
// }

// class _ItemChatWidgetState extends State<ItemChatWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Dismissible(
//       key: Key(widget.conversationData.id.toString()),
//       background: Container(
//         color: AppColors.transparent,
//       ),
//       secondaryBackground: Container(
//         color: AppColors.primaryColor,
//         child: const Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//         ),
//       ),
//       confirmDismiss: (direction) async {
//         return false; // Prevent dismissal
//       },
//       child: InkWell(
//         onTap: () => context.navigateToPage(
//           const MessagesScreen(
//             uuid: '',
//           ),
//           pageTransitionType: PageTransitionType.rightToLeft,
//         ),
//         child: ListTile(
//           leading: const CircleAvatar(
//               //     backgroundImage: AssetImage(Assets.temporaryProfile),
//               ),
//           title: Text(
//             'Unknown',
//             style: Styles.style14700.copyWith(color: AppColors.black),
//             overflow: TextOverflow.ellipsis,
//             maxLines: 1,
//           ),
//           subtitle: Text(
//             'No message',
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: Styles.style12700.copyWith(color: AppColors.subTextThinColor),
//           ),
//           trailing: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 '22',
//                 style: Styles.style12400.copyWith(color: AppColors.subTextThinColor),
//               ),
//               Container(
//                 padding: const EdgeInsets.all(6).w,
//                 decoration: const BoxDecoration(
//                   color: AppColors.primaryColor,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Text(
//                   '2',
//                   style: TextStyle(
//                     fontSize: 11.sp,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // String formatTimeDifference(String createdAt) {
//   //   final DateTime createdAtDate = DateTime.parse(createdAt);
//   //   final DateTime now = DateTime.now();

//   //   final Duration difference = now.difference(createdAtDate);

//   //   if (difference.inMinutes < 60) {
//   //     // If the difference is less than an hour, display in minutes
//   //     return '${difference.inMinutes} min ago';
//   //   } else if (difference.inHours < 24) {
//   //     // If the difference is less than a day, display in hours
//   //     return '${difference.inHours} hours ago';
//   //   } else {
//   //     // If the difference is more than a day, display in days
//   //     return '${difference.inDays} days ago';
//   //   }
//   // }
// }

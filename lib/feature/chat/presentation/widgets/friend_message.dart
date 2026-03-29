// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:user_workers/core/themes/colors.dart';
// import 'package:user_workers/core/themes/styles.dart';
// import 'package:user_workers/core/utils/extensions.dart';
// import 'package:user_workers/core/utils/screen_spaces_extension.dart';


// class FriendMessage extends StatefulWidget {
//   const FriendMessage({
//     super.key,
//     required this.messageModel,
//   });

//   final Message messageModel;

//   @override
//   State<FriendMessage> createState() => _FriendMessageState();
// }

// class _FriendMessageState extends State<FriendMessage> {
//   String formatTime(String dateTimeString) {
//     try {
//       final DateTime dateTime = DateTime.parse(dateTimeString);
//       return DateFormat.jm().format(dateTime);
//     } catch (e) {
//       return dateTimeString;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             const CircleAvatar(
//            //   backgroundImage: AssetImage(Assets.temporaryProfile),
//             ),
//             10.ESW(),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8).w,
//                   constraints: BoxConstraints(maxWidth: context.screenWidth * .7),
//                   decoration: BoxDecoration(
//                     color: AppColors.secondPrimaryColor.withOpacity(.2),
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(8.w),
//                       topRight: Radius.circular(8.w),
//                       bottomRight: Radius.circular(8.w),
//                     ),
//                   ),
//                   child: Text(
//                     '${widget.messageModel.body}',
//                     style: Styles.style12400.copyWith(color: AppColors.subTextColor),
//                   ),
//                 ),
//                 5.ESH(),
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       formatTime('${widget.messageModel.createdAt}'),
//                       style: Styles.style10400.copyWith(color: AppColors.subTextThinColor),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

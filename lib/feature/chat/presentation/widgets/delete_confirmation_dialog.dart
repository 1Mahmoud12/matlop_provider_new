// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:user_workers/core/themes/colors.dart';


// class DeleteConfirmationDialog extends StatefulWidget {
//   final ChatCubit chatCubit;
//   final String userId;
//   const DeleteConfirmationDialog({super.key, required this.chatCubit, required this.userId});

//   @override
//   DeleteConfirmationDialogState createState() => DeleteConfirmationDialogState();
// }

// class DeleteConfirmationDialogState extends State<DeleteConfirmationDialog> {
//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<ChatCubit, ChatState>(
//       listener: (context, state) {
//         if (state is MessageConfirmeDeleted) {
//           Navigator.of(context).pop();
//         }
//       },
//       child: AlertDialog(
//         backgroundColor: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         title: Text(
//           'confirm delete'.tr(),
//           style: const TextStyle(
//             color: Color(0xff071FD7),
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         content: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text('Are you sure you want to delete?'.tr()),
//             const SizedBox(height: 16),
//             if (isLoading)
//               const Center(
//                 child: CircularProgressIndicator(
//                   color: AppColors.primaryColor,
//                 ),
//               )
//             else
//               const SizedBox.shrink(),
//           ],
//         ),
//         actions: _buildDialogActions(context),
//       ),
//     );
//   }

//   List<Widget> _buildDialogActions(BuildContext context) {
//     if (isLoading) {
//       return [];
//     } else {
//       return [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: Text(
//             'cancel'.tr(),
//             style: const TextStyle(
//               color: Color(0xff071FD7),
//             ),
//           ),
//         ),
//         TextButton(
//           onPressed: () async {
//             setState(() {
//               isLoading = true;
//             });
//             widget.chatCubit.deleteMessageSelection(widget.userId);
//           },
//           child: Text(
//             'delete'.tr(),
//             style: const TextStyle(
//               color: Color(0xff071FD7),
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ];
//     }
//   }
// }

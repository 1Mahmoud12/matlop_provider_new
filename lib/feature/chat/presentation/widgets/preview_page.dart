// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tashiraa/core/component/video/video_widget.dart';
// import 'package:tashiraa/core/themes/color_constraint.dart';
// import 'package:tashiraa/core/utils/extensions.dart';
// import 'package:tashiraa/core/utils/file.dart';
// import 'package:tashiraa/core/utils/screen_spaces_extension.dart';
// import 'package:tashiraa/core/utils/utils.dart';
// import 'package:tashiraa/features/chat/presentation/manager/chat_cubit.dart';

// class PreviewPage extends StatelessWidget {
//   final List<String>? images;
//   final List<XFile>? imagesFiles;
//   final bool sendMessage;
//   final String? subjectId;
//   final String? code;
//   final String? classId;
//   final String? idStudent;
//   final String? studentName;
//   final int? initialPage;

//   const PreviewPage({
//     super.key,
//     this.images,
//     this.sendMessage = false,
//     this.imagesFiles,
//     this.classId,
//     this.subjectId,
//     this.idStudent,
//     this.code,
//     this.initialPage,
//     this.studentName,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final double widthMedia = MediaQuery.sizeOf(context).width;
//     final double heightMedia = MediaQuery.sizeOf(context).height;
//     final PageController pageController = PageController(initialPage: initialPage ?? 0);

//     bool loading = false;
//     return BlocConsumer<ChatCubit, ChatState>(
//       listener: (context, state) {
//         if (state is UploadLoadingState) {
//           loading = true;
//           printDM('ChatCubit');
//         }
//       },
//       builder: (context, state) => SafeArea(
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             Stack(
//               alignment: Alignment.bottomRight,
//               children: [
//                 if ((images ?? []).isNotEmpty)
//                   PageView.builder(
//                     controller: pageController,
//                     itemBuilder: (context, index) => SizedBox(
//                       width: MediaQuery.sizeOf(context).width,
//                       child: Stack(
//                         alignment: Alignment.bottomCenter,
//                         children: [
//                           Center(
//                             child: Utils.selectImageExtension(originalString: images![index])
//                                 ? Image.network(
//                                     images![index],
//                                     //width: widthMedia,
//                                     fit: BoxFit.cover,
//                                   )
//                                 : SizedBox(
//                                     height: context.screenHeight,
//                                     width: context.screenWidth,
//                                     child: ChewieDemo(
//                                       path: images![index],
//                                       file: false,
//                                     ),
//                                   ),
//                           ),
//                           if (!sendMessage)
//                             GestureDetector(
//                               onTap: () async {
//                                 await FileDetails.openFile(
//                                   images![index],
//                                 );
//                               },
//                               child: const Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: CircleAvatar(
//                                   backgroundColor: AppColors.primaryColor,
//                                   child: Icon(
//                                     Icons.download,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                     itemCount: images!.length,
//                   ),
//                 if ((imagesFiles ?? []).isNotEmpty)
//                   PageView.builder(
//                     itemBuilder: (context, index) => Center(
//                       child: Utils.selectImageExtension(originalString: imagesFiles![index].path)
//                           ? Image.file(
//                               File(imagesFiles![index].path),
//                               //width: widthMedia,
//                               fit: BoxFit.cover,
//                             )
//                           : SizedBox(
//                               height: context.screenHeight,
//                               width: context.screenWidth,
//                               child: ChewieDemo(
//                                 path: imagesFiles![index].path,
//                                 file: false,
//                               ),
//                             ),
//                     ),
//                     // separatorBuilder: (context, index) => 20.sizedBoxWidth,
//                     itemCount: imagesFiles!.length,
//                   ),
//                 if (sendMessage)
//                   GestureDetector(
//                     onTap: () async {
//                       await ChatCubit.of(context).uploadImages(xfilePick: imagesFiles!).then((value) async {
//                         if (ChatCubit.of(context).selectedImages.isNotEmpty) {
//                           ChatCubit.of(context).selectedImages.forEach((element) async {
//                             await ChatCubit.of(context).createMessageChatsRemoteDataSource({
//                               'id': subjectId,
//                               'classId': classId,
//                               'memberId': idStudent,
//                               'studentName': studentName,
//                               'code': code,
//                               'image': element,
//                               'dateTime': DateTime.now().toString(),
//                               'createdAt': DateTime.now(),
//                             });
//                           });

//                           Navigator.pop(context);
//                         }
//                       });
//                     },
//                     child: const Directionality(
//                       textDirection: TextDirection.ltr,
//                       child: Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: CircleAvatar(
//                           backgroundColor: AppColors.primaryColor,
//                           child: Icon(
//                             Icons.send,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             if (loading)
//               Container(
//                 height: heightMedia * .08,
//                 width: widthMedia * .7,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: AppColors.primaryColor,
//                 ),
//                 child: Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         'Loading',
//                         style: TextStyle(fontSize: 25, color: Colors.white, decoration: TextDecoration.none),
//                       ),
//                       15.ESW(),
//                       const CircularProgressIndicator(color: Colors.white),
//                     ],
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

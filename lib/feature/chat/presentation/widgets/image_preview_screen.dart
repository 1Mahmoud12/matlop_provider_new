import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matlop_provider/core/component/custom_text_form_field.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/app_icons.dart';
import 'package:matlop_provider/core/utils/extensions.dart';
import 'package:matlop_provider/feature/chat/presentation/manager/messageCubit/message_cubit.dart';

class ImagePreviewScreen extends StatefulWidget {
  const ImagePreviewScreen({super.key, required this.selectedImage, required this.techId, this.onTapSendMessage, required this.userId});
  final List<File> selectedImage;
  final void Function()? onTapSendMessage;
  final String userId;
  final String techId;

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  // final ImagePainterController _controller = ImagePainterController(
  //   color: Colors.green,
  //   mode: PaintMode.line,
  // );
  // ImagePainter.asset(
  //               widget.selectedImage.path,
  //               controller: _controller,
  //               scalable: true,
  //               textDelegate: TextDelegate(),
  //             ),
  @override
  Widget build(BuildContext context) {
    final messageCubit = BlocProvider.of<MessageCubit>(context);
    return PopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: widget.selectedImage.length,
                  itemBuilder: (context, index) {
                    return Image.file(
                      widget.selectedImage[index],
                      fit: BoxFit.contain,
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: CustomTextFormField(
                          outPadding: EdgeInsets.zero,
                          controller: messageCubit.sendController,
                          hintText: 'Add a caption...'.tr(),
                          mainAxisSize: MainAxisSize.min,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            MessageCubit.of(context).onSendIcon(userId: widget.userId, techId: widget.techId);
                            // Navigator.pop(context);
                          },
                          // onTap: () async {
                          //   //chatCubit.sendChatMessage(cha);
                          //   Navigator.pop(context);
                          //   chatCubit.messageList.insert(
                          //     0,
                          //     MessageModelFirebase(
                          //       message: chatCubit.textEditingController.text,
                          //       image: widget.selectedImage.path[0],
                          //       file: '',
                          //       id: '',
                          //       isSelected: '',
                          //       createdAt: DateTime.now().toString(),
                          //     ),
                          //   );
                          // },
                          child: Container(
                            padding: const EdgeInsets.all(10).w,
                            //    margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(10.r)),
                            child: SvgPicture.asset(
                              AppIcons.sendIcon,
                              colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                              width: context.screenWidth * .07,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

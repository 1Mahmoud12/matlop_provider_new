import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matlop_provider/core/component/custom_text_form_field.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/feature/chat/presentation/manager/messageCubit/message_cubit.dart';

class ReplyTextFieldMessage extends StatefulWidget {
  const ReplyTextFieldMessage({super.key, required this.controller, this.onTapAttachment});
  final TextEditingController controller;
  final void Function()? onTapAttachment;
  @override
  State<ReplyTextFieldMessage> createState() => _ReplyTextFieldMessageState();
}

class _ReplyTextFieldMessageState extends State<ReplyTextFieldMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  width: 5,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      color: AppColors.grey.withOpacity(0.2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'You',
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.primaryColor),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () => MessageCubit.of(context).closeIsSwiped(),
                              child: Icon(
                                Icons.close,
                                size: 16.sp,
                                color: Colors.grey.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          MessageCubit.of(context).repliedMessage,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.textColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomTextFormField(
            prefixIconConstraints: const BoxConstraints(maxWidth: 40),
            borderColor: Colors.transparent,
            outPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            height: .08,
            controller: widget.controller,
            onChange: (value) {},
            hintText: 'Write your message...'.tr(),
            focusedBorderColor: AppColors.transparent,
            enabledBorder: AppColors.transparent,
            // prefixIcon: Row(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     GestureDetector(
            //       onTap: widget.onTapAttachment,
            //       child: SvgPicture.asset(
            //         AppIcons.attachment,
            //         width: context.screenWidth * .07,
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 10,
            //     ),
            //   ],
            // ),
          ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:matlop_provider/core/utils/app_icons.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/feature/menu/views/commonQuestions/data/models/common_question_model.dart';

class CustomExpandablePanel extends StatelessWidget {
  const CustomExpandablePanel({
    super.key,
    required this.expandableController,
    required this.questionData,
  });

  final ExpandableController expandableController;

  final QuestionData? questionData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ExpandablePanel(
        controller: expandableController,
        header: GestureDetector(
          onTap: () {
            expandableController.toggle();
          },
          child: AnimatedBuilder(
            animation: expandableController,
            builder: (context, _) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: expandableController.expanded ? Radius.zero : const Radius.circular(8),
                    bottomRight: expandableController.expanded ? Radius.zero : const Radius.circular(8),
                    topRight: const Radius.circular(8),
                    topLeft: const Radius.circular(8),
                  ),
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.grey.withOpacity(0.2)),
                    left: BorderSide(color: Colors.grey.withOpacity(0.2)),
                    right: BorderSide(color: Colors.grey.withOpacity(0.2)),
                    bottom: expandableController.expanded ? BorderSide.none : BorderSide(color: Colors.grey.withOpacity(0.2)),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        (context.locale.languageCode == 'ar' ? questionData?.arTitle : questionData?.enTitle) ?? Constants.unKnownValue,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    SvgPicture.asset(
                      expandableController.expanded ? AppIcons.arrowUpExpandablePanel : AppIcons.arrowDownExpandablePanel,
                      colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        collapsed: Container(),
        expanded: Container(
          width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            color: Colors.white,
            border: Border(
              left: BorderSide(color: Colors.grey.withOpacity(0.2)),
              right: BorderSide(color: Colors.grey.withOpacity(0.2)),
              bottom: BorderSide(color: Colors.grey.withOpacity(0.2)),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HtmlWidget(
                (context.locale.languageCode == 'ar' ? questionData?.arDescription : questionData?.enDescription) ?? Constants.unKnownValue,
                //   style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.textColor.withOpacity(0.7), fontSize: 14.sp),
              ),
            ],
          ),
        ),
        theme: const ExpandableThemeData(
          hasIcon: false,
        ),
      ),
    );
  }
}

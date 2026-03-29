import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matlop_provider/core/component/custom_app_bar.dart';
import 'package:matlop_provider/core/utils/app_images.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/utils/empty_data_widget.dart';
import 'package:matlop_provider/core/utils/server_error_widget.dart';
import 'package:matlop_provider/feature/menu/views/commonQuestions/presentation/manager/cubit/faq_cubit.dart';
import 'package:matlop_provider/feature/menu/views/commonQuestions/presentation/widgets/custom_expandable_panel.dart';

class CommonQuestions extends StatefulWidget {
  const CommonQuestions({super.key});

  @override
  State<CommonQuestions> createState() => _CommonQuestionsState();
}

class _CommonQuestionsState extends State<CommonQuestions> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FaqCubit.of(context).getFQA(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List of expandable controllers for each panel
    final List<ExpandableController> expandableControllers = List.generate(
      ConstantModel.commonQuestionModel?.data?.length ?? 0,
      (_) => ExpandableController(),
    );

    return Scaffold(
      appBar: CustomAppBar(title: 'Common Questions'.tr()),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Responsive Image using ScreenUtil
                  Image.asset(
                    AppImages.commonQuestions,
                    width: 1.sw, // Screen width
                    height: 260.h, // Height based on screen size
                    fit: BoxFit.contain, // Adjust image aspect ratio
                  ),
                  const SizedBox(height: 10),
                  // Responsive Text using ScreenUtil
                  Text(
                    'All you need to know'.tr(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 18.sp, // Responsive font size
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          BlocConsumer<FaqCubit, FaqState>(
            listener: (context, state) {
              if (state is FaqSuccess) {
                setState(() {});
              }
            },
            builder: (context, state) {
              return ConstantModel.commonQuestionModel!=null&&ConstantModel.commonQuestionModel!.data!=null&&ConstantModel.commonQuestionModel!.data!.isNotEmpty
                  ? SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList.builder(
                        itemCount: expandableControllers.length,
                        itemBuilder: (context, index) {
                          return CustomExpandablePanel(
                            questionData: ConstantModel.commonQuestionModel!.data![index],
                            expandableController: expandableControllers[index],
                          );
                        },
                      ),
                    )
                  : state is FaqError
                      ? SliverToBoxAdapter(
                          child: ServerErrorWidget(
                            data: 'no common questions'.tr(),
                          ),
                        )
                      :  SliverToBoxAdapter(child: EmptyData(title: 'no common questions'.tr(),showImage: false,));
            },
          ),
        ],
      ),
    );
  }
}

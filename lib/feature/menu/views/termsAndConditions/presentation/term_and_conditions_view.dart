import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/custom_app_bar.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/core/utils/empty_data_widget.dart';
import 'package:matlop_provider/core/utils/server_error_widget.dart';
import 'package:matlop_provider/feature/menu/views/termsAndConditions/presentation/manager/cubit/term_and_conditions_cubit.dart';
import 'package:matlop_provider/feature/menu/views/termsAndConditions/presentation/que_ans_widget.dart';

class TermAndConditionsView extends StatefulWidget {
  const TermAndConditionsView({super.key});

  @override
  State<TermAndConditionsView> createState() => _TermAndConditionsViewState();
}

class _TermAndConditionsViewState extends State<TermAndConditionsView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      TermAndConditionsCubit.of(context).getTermAndConditions(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Term And Conditions'.tr()),
      body: BlocBuilder<TermAndConditionsCubit, TermAndConditionsState>(
        builder: (context, state) {
          return ConstantModel.termAndConditionModel != null &&
                  ConstantModel.termAndConditionModel!.data != null &&
                  ConstantModel.termAndConditionModel!.data!.isNotEmpty
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        ...List.generate(
                          ConstantModel.termAndConditionModel?.data?.length ?? 0,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                MyCustomExpandablePanel(
                                    questionData: (context.locale.languageCode == 'en'
                                            ? ConstantModel.termAndConditionModel!.data![index].enName
                                            : ConstantModel.termAndConditionModel!.data![index].arName) ??
                                        Constants.unKnownValue,
                                    answerData: (context.locale.languageCode == 'en'
                                            ? ConstantModel.termAndConditionModel!.data![index].enDescription
                                            : ConstantModel.termAndConditionModel!.data![index].arDescription) ??
                                        Constants.unKnownValue),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : state is TermAndConditionsError
                  ? ServerErrorWidget(data: state.e)
                  : EmptyData(
                      title: 'no terms & conditions'.tr(),
                    );
        },
      ),
    );
  }
}

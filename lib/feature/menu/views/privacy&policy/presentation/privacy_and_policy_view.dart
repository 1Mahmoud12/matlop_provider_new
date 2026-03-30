import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/custom_app_bar.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/core/utils/empty_data_widget.dart';
import 'package:matlop_provider/core/utils/server_error_widget.dart';
import 'package:matlop_provider/feature/menu/views/privacy&policy/presentation/manager/cubit/privacy_and_policy_cubit.dart';
import 'package:matlop_provider/feature/menu/views/termsAndConditions/presentation/que_ans_widget.dart';

class PrivacyAndPolicyView extends StatefulWidget {
  const PrivacyAndPolicyView({super.key});

  @override
  State<PrivacyAndPolicyView> createState() => _PrivacyAndPolicyViewState();
}

class _PrivacyAndPolicyViewState extends State<PrivacyAndPolicyView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      PrivacyAndPolicyCubit.of(context).getPrivacyAndPolicy(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Privacy Policies'.tr()),
      body: BlocBuilder<PrivacyAndPolicyCubit, PrivacyAndPolicyState>(
        builder: (context, state) {
          return ConstantModel.privacyAndPolicyModel != null &&
                  ConstantModel.privacyAndPolicyModel!.data != null &&
                  ConstantModel.privacyAndPolicyModel!.data!.isNotEmpty
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        ...List.generate(
                          ConstantModel.privacyAndPolicyModel?.data?.length ?? 0,
                          (index) {
                            return ConstantModel.privacyAndPolicyModel!.data![index].userType == userCacheValue?.data?.profile?.technicalType
                                ? MyCustomExpandablePanel(
                                    questionData: (context.locale.languageCode == 'en'
                                            ? ConstantModel.privacyAndPolicyModel!.data![index].enTitle
                                            : ConstantModel.privacyAndPolicyModel!.data![index].arTitle) ??
                                        Constants.unKnownValue,
                                    answerData: (context.locale.languageCode == 'en'
                                            ? ConstantModel.privacyAndPolicyModel!.data![index].enDescription
                                            : ConstantModel.privacyAndPolicyModel!.data![index].arDescription) ??
                                        Constants.unKnownValue)
                                : const SizedBox();
                          },
                        ),
                      ],
                    ),
                  ),
                )
              : state is PrivacyAndPolicyError
                  ? ServerErrorWidget(
                      data: state.e,
                    )
                  : EmptyData(
                      title: 'no privacy & policy'.tr(),
                    );
        },
      ),
    );
  }
}

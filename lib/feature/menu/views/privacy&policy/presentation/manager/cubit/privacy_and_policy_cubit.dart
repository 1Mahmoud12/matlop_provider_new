import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/loading_widget.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/menu/views/privacy&policy/data/dataSource/privacy_and_policy_data_source.dart';

part 'privacy_and_policy_state.dart';

class PrivacyAndPolicyCubit extends Cubit<PrivacyAndPolicyState> {
  PrivacyAndPolicyCubit() : super(PrivacyAndPolicyInitial());

  static PrivacyAndPolicyCubit of(BuildContext context) => BlocProvider.of<PrivacyAndPolicyCubit>(context);

  void getPrivacyAndPolicy(BuildContext context) async {
    animationDialogLoading(
      context,
    );
    await PrivacyAndPolicyDataSource.getPrivacyAndPolicy(context).then((value)async {
    if(context.mounted)  closeDialog(context);
      value.fold((l) {
       // Utils.showToast(title: l.errMessage, state: UtilState.error);
        emit(PrivacyAndPolicyError(e: l.errMessage));
      }, (r) {
        ConstantModel.privacyAndPolicyModel = r;

        emit(PrivacyAndPolicySuccess());
      });
    });
  }
}

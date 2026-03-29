import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/loading_widget.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/feature/menu/views/termsAndConditions/data/dataSource/term_and_condition_data_source.dart';

part 'term_and_conditions_state.dart';

class TermAndConditionsCubit extends Cubit<TermAndConditionsState> {
  TermAndConditionsCubit() : super(TermAndConditionsInitial());

  static TermAndConditionsCubit of(BuildContext context) => BlocProvider.of<TermAndConditionsCubit>(context);

  void getTermAndConditions(BuildContext context) async {
    animationDialogLoading(context);
    await TermAndConditionDataSource.getTermAndConditions(context).then((value)async {
    if(context.mounted)  closeDialog(context);
      value.fold((l) {
       // Utils.showToast(title: l.errMessage, state: UtilState.error);
        emit(TermAndConditionsError(e: l.errMessage));
      }, (r) {
        ConstantModel.termAndConditionModel = r;

        emit(TermAndConditionsSuccess());
      });
    });
  }
}

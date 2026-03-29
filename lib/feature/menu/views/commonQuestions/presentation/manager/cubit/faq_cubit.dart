import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/loading_widget.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/menu/views/commonQuestions/data/dataSource/common_question_data_source.dart';

part 'faq_state.dart';

class FaqCubit extends Cubit<FaqState> {
  FaqCubit() : super(FaqInitial());
  static FaqCubit of(BuildContext context) => BlocProvider.of<FaqCubit>(context);

  void getFQA(BuildContext context) async {
    animationDialogLoading(context);
    await CommonQuestionDataSource.getFAQ(context).then((value) {
    if(context.mounted) closeDialog(context);
      value.fold((l) {
        emit(FaqError(e: l.errMessage));
      }, (r) {
        ConstantModel.commonQuestionModel = r;
        emit(FaqSuccess());
      });
    });
  }
}

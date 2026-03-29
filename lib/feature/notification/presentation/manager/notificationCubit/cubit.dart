import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/utils/loading_dialog.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/notification/data/dataSource/notification_data_source.dart';

part 'state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  static NotificationCubit of(BuildContext context) => BlocProvider.of<NotificationCubit>(context);
  final NotificationDataSourceImpl serviceDataSourceImpl = NotificationDataSourceImpl();
  int countUnReadNotification = 0;

  void getNotification(BuildContext context) async {
    emit(NotificationLoading());
    if (ConstantModel.notificationModel == null) animationDialogLoading(context);
    await serviceDataSourceImpl.getNotification().then(
      (value) async {
        if (ConstantModel.notificationModel == null) closeDialog(context);
        value.fold((l) {
          //Utils.showToast(title: l.errMessage, state: UtilState.error);
          emit(NotificationError(e: l.errMessage));
        }, (r) {
          countUnReadNotification = 0;
          ConstantModel.notificationModel = r;
          r.data?.data?.forEach(
            (element) {
              if (element.isSeen == false) {
                countUnReadNotification++;
              }
            },
          );
          emit(NotificationSuccess());
        });
      },
    );
  }

  void readNotification(BuildContext context, int idNotification) async {
    emit(ReadNotificationLoading());
    animationDialogLoading(context);
    await serviceDataSourceImpl.readNotification(idNotification: idNotification).then(
      (value) {
        closeDialog(context);
        value.fold((l) {
          //Utils.showToast(title: l.errMessage, state: UtilState.error);
          emit(ReadNotificationError(e: l.errMessage));
        }, (r) {
          Utils.showToast(title: r, state: UtilState.success);
          final index = ConstantModel.notificationModel?.data?.data?.indexWhere((element) => element.notificationId == idNotification);
          if (index != null && index != -1) {
            ConstantModel.notificationModel?.data?.data?[index].isSeen = true;
          }
          countUnReadNotification--;
          emit(ReadNotificationSuccess());
        });
      },
    );
  }
}

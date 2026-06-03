import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/loading_widget.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/auth/login/presentation/login_view.dart';
import 'package:matlop_provider/feature/auth/login/presentation/manager/cubit/login_cubit.dart';
import 'package:matlop_provider/feature/menu/views/settings/data/dataSource/delete_account_data_source.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit() : super(DeleteAccountInitial());
  static DeleteAccountCubit of(BuildContext context) => BlocProvider.of<DeleteAccountCubit>(context);

  void deleteAccount(BuildContext context) async {
    animationDialogLoading(context);

    await DeleteAccountDataSource.deleteAccount(context: context).then(
      (value) {
        value.fold((l) {
          Navigator.pop(context); // Close loading dialog
          Utils.showToast(title: l.errMessage, state: UtilState.error);
          emit(DeleteAccountError(e: l.errMessage));
        }, (r) {
          // Clear session data same as logout
          userCacheValue = null;
          profileCacheValue = null;
          userCache?.put(userCacheKey, '{}');
          userCache?.put(profileCacheKey, '{}');
          Constants.token = '';
          Constants.refreshToken = '';
          Constants.fcmToken = '';

          emit(DeleteAccountSuccess());

          Utils.showToast(title: 'account_deleted_successfully'.tr(), state: UtilState.success);

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => LoginCubit(),
                child: const LoginView(),
              ),
            ),
            (route) => false,
          );
        });
      },
    );
  }
}

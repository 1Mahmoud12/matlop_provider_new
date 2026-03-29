import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/auth/forgetPassword/data/reset_data_source.dart';
import 'package:matlop_provider/feature/auth/login/presentation/login_view.dart';
import 'package:matlop_provider/feature/auth/login/presentation/manager/cubit/login_cubit.dart';
import 'package:matlop_provider/feature/auth/otp/presentation/otp_view.dart';
import 'package:matlop_provider/feature/auth/resetPassword/set_new_password_view.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  static ResetPasswordCubit of(BuildContext context) => BlocProvider.of(context);
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController forgetPasswordController = TextEditingController();

  final ResetPasswordDataSourceInterface loginDataSource = ResetPasswordDataSource();

  void verifyPhoneNumber({required BuildContext context}) {
    emit(ResetPasswordLoading());
    loginDataSource.postResetPassword(mobileNumber: phoneController.text).then(
      (value) async {
        value.fold(
          (l) {
            Utils.showToast(title: l.errMessage, state: UtilState.error);
            emit(ResetPasswordError(e: l.errMessage));
          },
          (r) async {
            Utils.showToast(title: r, state: UtilState.success);

            //   userCacheValue = r;
            // Constants.token = r.data?.tokenType ?? '';

            context.navigateToPage(
              BlocProvider.value(
                value: BlocProvider.of<ResetPasswordCubit>(context),
                child: OtpView(
                  onCompleted: (p0) {
                    verifyOtp(context: context, otp: p0);
                  },
                ),
              ),
            );

            // await userCache?.put(userCacheKey, jsonEncode(r.toJson()));
            // await userCache?.put(rememberMeKey, rememberMe);
            emit(ResetPasswordSuccess());
          },
        );
      },
    );
  }

  void verifyOtp({required BuildContext context, required String otp}) {
    emit(VerifyLoading());
    loginDataSource.verifyOtp(mobile: phoneController.text, otp: otp).then(
      (value) async {
        value.fold(
          (l) {
            Utils.showToast(title: l.errMessage, state: UtilState.error);
            emit(VerifyError(e: l.errMessage));
          },
          (r) async {
            Utils.showToast(title: r, state: UtilState.success);

            //   userCacheValue = r;
            // Constants.token = r.data?.tokenType ?? '';

            context.navigateToPage(
              BlocProvider.value(
                value: BlocProvider.of<ResetPasswordCubit>(context),
                child: const SetNewPasswordView(),
              ),
            );

            emit(VerifySuccess());
          },
        );
      },
    );
  }

  void resetPassword({required BuildContext context}) {
    emit(VerifyLoading());
    loginDataSource
        .resetPassword(mobile: phoneController.text, password: passwordController.text, confirmPassword: confirmPasswordController.text)
        .then(
      (value) async {
        value.fold(
          (l) {
            Utils.showToast(title: l.errMessage, state: UtilState.error);
            emit(VerifyError(e: l.errMessage));
          },
          (r) async {
            Utils.showToast(title: r, state: UtilState.success);

            //   userCacheValue = r;
            // Constants.token = r.data?.tokenType ?? '';

            context.navigateToPage(
              BlocProvider(
                create: (context) => LoginCubit(),
                child: const LoginView(),
              ),
            );

            emit(VerifySuccess());
          },
        );
      },
    );
  }
}

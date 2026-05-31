import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/auth/forgetPassword/data/reset_data_source.dart';
import 'package:matlop_provider/feature/auth/login/presentation/login_view.dart';
import 'package:matlop_provider/feature/auth/login/presentation/manager/cubit/login_cubit.dart';
import 'package:matlop_provider/feature/auth/resetPassword/presentation/reset_password_view.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  static ResetPasswordCubit of(BuildContext context) => BlocProvider.of(context);

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  /// Message returned by the forget-password API (shown on ResetPasswordView).
  String resetMessage = '';

  final ResetPasswordDataSourceInterface loginDataSource = ResetPasswordDataSource();

  // ── Step 1: send OTP ────────────────────────────────────────────────────────
  void verifyPhoneNumber({required BuildContext context}) {
    emit(ResetPasswordLoading());
    final isArabic = context.locale.languageCode == 'ar';
    loginDataSource
        .postResetPassword(mobileNumber: phoneController.text, isArabic: isArabic)
        .then((value) {
      value.fold(
        (l) {
          Utils.showToast(title: l.errMessage, state: UtilState.error);
          emit(ResetPasswordError(e: l.errMessage));
        },
        (r) {
          resetMessage = r;
          Utils.showToast(
            title: 'A code has been sent to your phone number. Please enter it'.tr(),
            state: UtilState.success,
          );
          context.navigateToPage(
            BlocProvider.value(
              value: BlocProvider.of<ResetPasswordCubit>(context),
              child: const ResetPasswordView(),
            ),
          );
          emit(ResetPasswordSuccess());
        },
      );
    });
  }

  // ── Step 2: reset password (OTP + new password in one call) ────────────────
  void resetPassword({required BuildContext context}) {
    emit(VerifyLoading());
    loginDataSource
        .resetPassword(
      mobile: phoneController.text,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
      verificationCode: otpController.text,
    )
        .then((value) {
      value.fold(
        (l) {
          Utils.showToast(title: l.errMessage, state: UtilState.error);
          emit(VerifyError(e: l.errMessage));
        },
        (r) {
          emit(VerifySuccess());
          Utils.showToast(
            title: 'reset_password_success_body'.tr(),
            state: UtilState.success,
          );
          if (context.mounted) {
            context.navigateToPage(
              BlocProvider(
                create: (context) => LoginCubit(),
                child: const LoginView(),
              ),
            );
          }
        },
      );
    });
  }
}

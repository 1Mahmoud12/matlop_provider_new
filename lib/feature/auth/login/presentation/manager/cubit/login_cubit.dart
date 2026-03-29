import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/core/utils/notification/notification.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/auth/login/data/dataSource/login_data_source.dart';
import 'package:matlop_provider/feature/auth/otp/presentation/otp_view.dart';
import 'package:matlop_provider/feature/bottomNavBarScreen/bottom_nav_bar_view.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit of(BuildContext context) => BlocProvider.of<LoginCubit>(context);
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final LoginDataSourceInterface loginDataSource = LoginDataSource();

  void login({required BuildContext context}) {
    emit(LoginLoading());
    loginDataSource.postLogin(context: context, email: phoneController.text, password: passwordController.text).then(
      (value) async {
        value.fold(
          (l) {
            Utils.showToast(title: l.errMessage, state: UtilState.error);
            emit(LoginError(e: l.errMessage));
          },
          (r) async {
            //Utils.showToast(title: 'Login Successfully', state: UtilState.success);

            context.navigateToPage(
              OtpView(
                onCompleted: (p0) {
                  verifyOtp(context: context, otp: p0);
                },
              ),
            );
            // userCacheValue = r;
            // Constants.token = r.data?.accessToken ?? '';
            // await userCache?.put(userCacheKey, jsonEncode(r.toJson()));
            // await userCache?.put(rememberMeKey, rememberMe);
            emit(LoginSuccess());
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
            //  Utils.showToast(title: r.message ?? Constants.unKnownValue, state: UtilState.success);

            userCacheValue = r;
            Constants.token = r.data?.accessToken ?? '';
            selectTokens();
            context.navigateToPage(
              const BottomNavBarView(),
            );
            await userCache?.put(userCacheKey, jsonEncode(r.toJson()));
            await userCache?.put(rememberMeKey, rememberMe);
            emit(VerifySuccess());
          },
        );
      },
    );
  }
}

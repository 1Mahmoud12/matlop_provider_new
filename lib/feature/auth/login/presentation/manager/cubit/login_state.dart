part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginError extends LoginState {
  final String e;

  LoginError({required this.e});
}

final class LoginSuccess extends LoginState {}

final class VerifyLoading extends LoginState {}

final class VerifyError extends LoginState {
  final String e;

  VerifyError({required this.e});
}

final class VerifySuccess extends LoginState {}

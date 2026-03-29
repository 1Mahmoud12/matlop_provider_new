part of 'reset_password_cubit.dart';

@immutable
sealed class ResetPasswordState {}

final class ResetPasswordInitial extends ResetPasswordState {}

final class ResetPasswordLoading extends ResetPasswordState {}

final class ResetPasswordError extends ResetPasswordState {
  final String e;

  ResetPasswordError({required this.e});
}

final class ResetPasswordSuccess extends ResetPasswordState {}

final class VerifyLoading extends ResetPasswordState {}

final class VerifyError extends ResetPasswordState {
  final String e;

  VerifyError({required this.e});
}

final class VerifySuccess extends ResetPasswordState {}

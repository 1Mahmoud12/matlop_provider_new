part of 'profile_cubit.dart';

@immutable
sealed class UpdateProfileState {}

final class UpdateProfileInitial extends UpdateProfileState {}

final class UpdateProfileLoading extends UpdateProfileState {}

final class UpdateProfileError extends UpdateProfileState {
  final String e;

  UpdateProfileError({required this.e});
}

final class UpdateProfileSuccess extends UpdateProfileState {}

final class VerifyLoading extends UpdateProfileState {}

final class VerifyError extends UpdateProfileState {
  final String e;

  VerifyError({required this.e});
}

final class VerifySuccess extends UpdateProfileState {}

part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterError extends RegisterState {
  final String e;

  RegisterError({required this.e});
}

final class RegisterSuccess extends RegisterState {}

final class GetAllTechnicalSpecialListLoading extends RegisterState {}

final class GetAllTechnicalSpecialListError extends RegisterState {
  final String e;

  GetAllTechnicalSpecialListError({required this.e});
}

final class GetAllTechnicalSpecialListSuccess extends RegisterState {}

final class AddTechnicalState extends RegisterState {}

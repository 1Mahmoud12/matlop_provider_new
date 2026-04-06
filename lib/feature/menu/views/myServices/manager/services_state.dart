part of 'services_cubit.dart';

abstract class ServicesState {}

class ServicesInitial extends ServicesState {}

class ServicesLoading extends ServicesState {}

class ServicesSuccess extends ServicesState {}

class ServicesError extends ServicesState {
  final String message;
  ServicesError(this.message);
}

class ServicesUpdateLoading extends ServicesState {}

class ServicesUpdateSuccess extends ServicesState {}

class ServicesUpdateError extends ServicesState {
  final String message;
  ServicesUpdateError(this.message);
}

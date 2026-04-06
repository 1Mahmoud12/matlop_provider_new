part of 'cities_cubit.dart';

abstract class CitiesState {}

class CitiesInitial extends CitiesState {}

class CitiesLoading extends CitiesState {}

class CitiesSuccess extends CitiesState {}

class CitiesError extends CitiesState {
  final String message;
  CitiesError(this.message);
}

class CitiesUpdateLoading extends CitiesState {}

class CitiesUpdateSuccess extends CitiesState {}

class CitiesUpdateError extends CitiesState {
  final String message;
  CitiesUpdateError(this.message);
}

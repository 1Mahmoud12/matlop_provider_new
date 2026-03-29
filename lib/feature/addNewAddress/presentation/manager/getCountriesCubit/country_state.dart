part of 'country_cubit.dart';

@immutable
sealed class CountryState {}

final class CountryInitial extends CountryState {}

final class CountryILoading extends CountryState {}

final class CountrySuccess extends CountryState {}

final class CountryError extends CountryState {
  final String e;

  CountryError({required this.e});
}

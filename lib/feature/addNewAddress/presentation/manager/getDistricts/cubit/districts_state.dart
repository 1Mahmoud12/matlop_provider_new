part of 'districts_cubit.dart';

sealed class DistrictsState extends Equatable {
  const DistrictsState();

  @override
  List<Object> get props => [];
}

final class DistrictsInitial extends DistrictsState {}

final class DistrictsLoading extends DistrictsState {}

final class DistrictsSuccess extends DistrictsState {}

final class DistrictsError extends DistrictsState {
  final String e;
  const DistrictsError({required this.e});
}

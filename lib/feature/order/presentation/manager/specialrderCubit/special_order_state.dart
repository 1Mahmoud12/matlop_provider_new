part of 'special_order_cubit.dart';

sealed class SpecialOrderState extends Equatable {
  const SpecialOrderState();

  @override
  List<Object> get props => [];
}

final class SpecialOrderInitial extends SpecialOrderState {}

final class SpecialOrderLoading extends SpecialOrderState {}

final class SpecialOrderError extends SpecialOrderState {
  final String e;
  const SpecialOrderError({required this.e});
}

final class SpecialOrderSuccess extends SpecialOrderState {
  final int timestamp;
  SpecialOrderSuccess() : timestamp = DateTime.now().microsecondsSinceEpoch;

  @override
  List<Object> get props => [timestamp];
}

final class SpecialOrderDetailsLoading extends SpecialOrderState {}

final class SpecialOrderDetailsError extends SpecialOrderState {
  final String e;
  const SpecialOrderDetailsError({required this.e});
}

final class SpecialOrderDetailsSuccess extends SpecialOrderState {}

part of 'details_special_order_cubit.dart';

sealed class DetailsSpecialOrderState extends Equatable {
  const DetailsSpecialOrderState();

  @override
  List<Object> get props => [];
}

final class DetailsSpecialOrderInitial extends DetailsSpecialOrderState {}

final class DetailsSpecialOrderLoading extends DetailsSpecialOrderState {}
final class DetailsSpecialOrderSuccess extends DetailsSpecialOrderState {}

final class DetailsSpecialOrderError extends DetailsSpecialOrderState {
  final String e;
  const DetailsSpecialOrderError({required this.e});
}

final class ChangeSpecialStatusLoading extends DetailsSpecialOrderState {}

final class ChangeSpecialStatusSuccess extends DetailsSpecialOrderState {
  final int newStatus;
  const ChangeSpecialStatusSuccess({required this.newStatus});
}

final class ChangeSpecialStatusError extends DetailsSpecialOrderState {
  final String e;
  const ChangeSpecialStatusError({required this.e});
}

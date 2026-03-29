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


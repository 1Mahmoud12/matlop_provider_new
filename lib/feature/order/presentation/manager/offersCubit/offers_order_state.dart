part of 'offers_order_cubit.dart';

sealed class OffersOrderState extends Equatable {
  const OffersOrderState();

  @override
  List<Object> get props => [];
}

final class OffersOrderInitial extends OffersOrderState {}

final class OffersOrderLoading extends OffersOrderState {}

final class OffersOrderError extends OffersOrderState {
  final String e;

  const OffersOrderError({required this.e});
}

final class OffersOrderSuccess extends OffersOrderState {}

final class OffersOrderDetailsLoading extends OffersOrderState {}

final class OffersOrderDetailsError extends OffersOrderState {
  final String e;

  const OffersOrderDetailsError({required this.e});
}

final class OffersOrderDetailsSuccess extends OffersOrderState {}

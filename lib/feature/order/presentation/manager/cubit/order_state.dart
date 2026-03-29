part of 'order_cubit.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}

final class OrderError extends OrderState {
  final String e;

  const OrderError({required this.e});
}

final class OrderSuccess extends OrderState {}

final class OrderDetailsLoading extends OrderState {}

final class OrderDetailsError extends OrderState {
  final String e;

  const OrderDetailsError({required this.e});
}

final class OrderDetailsSuccess extends OrderState {}

final class ChangeStatusLoading extends OrderState {}

final class ChangeStatusError extends OrderState {
  final String e;

  const ChangeStatusError({required this.e});
}

class ChangeStatusSuccess extends OrderState {
  final int newStatus;

  const ChangeStatusSuccess({required this.newStatus});
}

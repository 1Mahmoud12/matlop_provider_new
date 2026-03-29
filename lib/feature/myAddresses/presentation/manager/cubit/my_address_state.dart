part of 'my_address_cubit.dart';

sealed class MyAddressState extends Equatable {
  const MyAddressState();

  @override
  List<Object> get props => [];
}

final class MyAddressInitial extends MyAddressState {}

final class MyAddressLoading extends MyAddressState {}

final class MyAddressSuccess extends MyAddressState {}

final class MyAddressError extends MyAddressState {
  final String e;
  const MyAddressError({required this.e});
}

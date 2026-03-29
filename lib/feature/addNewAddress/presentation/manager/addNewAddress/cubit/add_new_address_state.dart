part of 'add_new_address_cubit.dart';

sealed class AddNewAddressState extends Equatable {
  const AddNewAddressState();

  @override
  List<Object> get props => [];
}

final class AddNewAddressInitial extends AddNewAddressState {}

final class AddNewAddressLoading extends AddNewAddressState {}

final class AddNewAddressSuccess extends AddNewAddressState {}

final class AddNewAddressError extends AddNewAddressState {
  final String e;

  const AddNewAddressError({required this.e});
}

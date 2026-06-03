part of 'delete_account_cubit.dart';

sealed class DeleteAccountState {
  const DeleteAccountState();
}

final class DeleteAccountInitial extends DeleteAccountState {}

final class DeleteAccountLoading extends DeleteAccountState {}

final class DeleteAccountSuccess extends DeleteAccountState {}

final class DeleteAccountError extends DeleteAccountState {
  final String e;

  const DeleteAccountError({required this.e});
}

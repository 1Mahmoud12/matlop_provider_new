part of 'wallet_cubit.dart';

sealed class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

final class WalletInitial extends WalletState {}

final class WalletLoading extends WalletState {}

final class WalletSuccess extends WalletState {}

final class WalletError extends WalletState {
  final String e;

  const WalletError({required this.e});
}

final class TransactionsLoading extends WalletState {}

final class TransactionsSuccess extends WalletState {}

final class TransactionsError extends WalletState {
  final String e;

  const TransactionsError({required this.e});
}

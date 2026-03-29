part of 'privacy_and_policy_cubit.dart';

sealed class PrivacyAndPolicyState extends Equatable {
  const PrivacyAndPolicyState();

  @override
  List<Object> get props => [];
}

final class PrivacyAndPolicyInitial extends PrivacyAndPolicyState {}

final class PrivacyAndPolicyLoading extends PrivacyAndPolicyState {}

final class PrivacyAndPolicySuccess extends PrivacyAndPolicyState {}

final class PrivacyAndPolicyError extends PrivacyAndPolicyState {
  final String e;

  const PrivacyAndPolicyError({required this.e});
}

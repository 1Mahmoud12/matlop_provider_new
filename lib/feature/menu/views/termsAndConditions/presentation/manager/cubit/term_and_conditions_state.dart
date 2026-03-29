part of 'term_and_conditions_cubit.dart';

sealed class TermAndConditionsState extends Equatable {
  const TermAndConditionsState();

  @override
  List<Object> get props => [];
}

final class TermAndConditionsInitial extends TermAndConditionsState {}

final class TermAndConditionLoading extends TermAndConditionsState {}

final class TermAndConditionsSuccess extends TermAndConditionsState {}

final class TermAndConditionsError extends TermAndConditionsState {
  final String e;

  const TermAndConditionsError({required this.e});
}

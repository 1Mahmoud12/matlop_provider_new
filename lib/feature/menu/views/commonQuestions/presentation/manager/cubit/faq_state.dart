part of 'faq_cubit.dart';

sealed class FaqState extends Equatable {
  const FaqState();

  @override
  List<Object> get props => [];
}

final class FaqInitial extends FaqState {}

final class FaqLoading extends FaqState {}

final class FaqSuccess extends FaqState {}

final class FaqError extends FaqState {
  final String e;

  const FaqError({required this.e});
}

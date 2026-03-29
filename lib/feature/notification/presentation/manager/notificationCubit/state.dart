part of 'cubit.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

final class NotificationLoading extends NotificationState {}

final class NotificationError extends NotificationState {
  final String e;

  NotificationError({required this.e});
}

final class NotificationSuccess extends NotificationState {}

final class ReadNotificationLoading extends NotificationState {}

final class ReadNotificationError extends NotificationState {
  final String e;

  ReadNotificationError({required this.e});
}

final class ReadNotificationSuccess extends NotificationState {}

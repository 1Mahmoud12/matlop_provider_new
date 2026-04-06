part of 'work_schedule_cubit.dart';

abstract class WorkScheduleState {}

class WorkScheduleInitial extends WorkScheduleState {}

class WorkScheduleLoading extends WorkScheduleState {}

class WorkScheduleSuccess extends WorkScheduleState {}

class WorkScheduleError extends WorkScheduleState {
  final String message;
  WorkScheduleError(this.message);
}

class WorkScheduleUpdateLoading extends WorkScheduleState {}

class WorkScheduleUpdateSuccess extends WorkScheduleState {}

class WorkScheduleUpdateError extends WorkScheduleState {
  final String message;
  WorkScheduleUpdateError(this.message);
}

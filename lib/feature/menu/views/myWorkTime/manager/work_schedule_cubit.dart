import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/auth/login/data/models/login_model.dart';
import 'package:matlop_provider/feature/menu/views/myWorkTime/data/work_schedule_data_source.dart';

part 'work_schedule_state.dart';

const List<String> kWeekdayNamesEn = [
  'Sunday',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
];

/// Single slot used for every selected day on save (no per-day time editing in UI).
const String kDefaultWorkStart = '09:00:00';
const String kDefaultWorkEnd = '17:00:00';

class WorkDayRow {
  final int dayOfWeek;
  final String dayName;
  bool selected;

  WorkDayRow({
    required this.dayOfWeek,
    required this.dayName,
    required this.selected,
  });
}

class WorkScheduleCubit extends Cubit<WorkScheduleState> {
  WorkScheduleCubit() : super(WorkScheduleInitial());

  static WorkScheduleCubit of(BuildContext context) => BlocProvider.of(context);

  final WorkScheduleDataSourceInterface _dataSource = WorkScheduleDataSource();

  List<WorkDayRow> days = [];
  Set<int> _baselineSelected = {};

  bool get hasChanges {
    final current = _currentSelectedSet();
    return current.length != _baselineSelected.length || !current.containsAll(_baselineSelected);
  }

  Set<int> _currentSelectedSet() => days.where((d) => d.selected).map((d) => d.dayOfWeek).toSet();

  Future<void> loadSchedules() async {
    emit(WorkScheduleLoading());

    final userId = userCacheValue?.data?.userId ?? -1;
    if (userId == -1) {
      emit(WorkScheduleError('User not found'.tr()));
      return;
    }

    final result = await _dataSource.getAllTechnicalWorkSchedules();

    result.fold(
      (f) => emit(WorkScheduleError(f.errMessage)),
      (all) {
        final mine = all.where((s) => s.technicalId == userId && s.dayOfWeek != null).toList();
        final byDay = {for (final s in mine) s.dayOfWeek!: s};

        days = List.generate(7, (dow) {
          final s = byDay[dow];
          final name = (s?.displayDayName ?? '').isNotEmpty ? s!.displayDayName : kWeekdayNamesEn[dow];
          return WorkDayRow(
            dayOfWeek: dow,
            dayName: name,
            selected: s != null,
          );
        });

        _baselineSelected = Set<int>.from(_currentSelectedSet());

        emit(WorkScheduleSuccess());
      },
    );
  }

  void toggleDay(int dayOfWeek) {
    final i = days.indexWhere((d) => d.dayOfWeek == dayOfWeek);
    if (i == -1) {
      return;
    }
    days[i].selected = !days[i].selected;
    emit(WorkScheduleSuccess());
  }

  Future<void> saveSchedules() async {
    final userId = userCacheValue?.data?.userId ?? -1;
    if (userId == -1) {
      Utils.showToast(title: 'User not found'.tr(), state: UtilState.error);
      return;
    }

    emit(WorkScheduleUpdateLoading());

    final schedules = days
        .where((d) => d.selected)
        .map(
          (d) => WorkScheduleModel(
            dayOfWeek: d.dayOfWeek,
            startTime: kDefaultWorkStart,
            endTime: kDefaultWorkEnd,
          ).toUpdateScheduleMap(),
        )
        .toList();

    final result = await _dataSource.updateMyWorkSchedule(
      technicalUserId: userId,
      schedules: schedules,
    );

    result.fold(
      (failure) {
        emit(WorkScheduleUpdateError(failure.errMessage));
        Utils.showToast(title: failure.errMessage, state: UtilState.error);
      },
      (_) {
        _baselineSelected = Set<int>.from(_currentSelectedSet());
        emit(WorkScheduleUpdateSuccess());
        Utils.showToast(title: 'Work schedule updated'.tr(), state: UtilState.success);
      },
    );
  }
}

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

class DayScheduleRow {
  final int dayOfWeek;
  final String dayName;
  String startTime;
  String endTime;

  /// True when times came from [userCacheValue] profile `workSchedules` for this [dayOfWeek].
  bool fromUserCache;

  DayScheduleRow({
    required this.dayOfWeek,
    required this.dayName,
    required this.startTime,
    required this.endTime,
    this.fromUserCache = false,
  });
}

class WorkScheduleCubit extends Cubit<WorkScheduleState> {
  WorkScheduleCubit() : super(WorkScheduleInitial());

  static WorkScheduleCubit of(BuildContext context) => BlocProvider.of(context);

  final WorkScheduleDataSourceInterface _dataSource = WorkScheduleDataSource();

  List<DayScheduleRow> rows = [];
  List<DayScheduleRow> _baseline = [];

  bool get hasChanges {
    if (_baseline.length != rows.length) {
      return true;
    }
    for (var i = 0; i < rows.length; i++) {
      if (rows[i].startTime != _baseline[i].startTime || rows[i].endTime != _baseline[i].endTime) {
        return true;
      }
    }
    return false;
  }

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

        final cacheList = userCacheValue?.data?.profile?.workSchedules ?? <WorkScheduleModel>[];
        final cacheByDay = {
          for (final w in cacheList)
            if (w.dayOfWeek != null) w.dayOfWeek!: w,
        };

        rows = List.generate(7, (dow) {
          final cached = cacheByDay[dow];
          final s = byDay[dow];

          final cacheHasTimes = cached != null &&
              (cached.startTime ?? '').isNotEmpty &&
              (cached.endTime ?? '').isNotEmpty;

          if (cacheHasTimes) {
            final name = cached.displayDayName.isNotEmpty ? cached.displayDayName : kWeekdayNamesEn[dow];
            return DayScheduleRow(
              dayOfWeek: dow,
              dayName: name,
              startTime: cached.startTime ?? '09:00:00',
              endTime: cached.endTime ?? '17:00:00',
              fromUserCache: true,
            );
          }

          final name = (s?.displayDayName ?? '').isNotEmpty ? s!.displayDayName : kWeekdayNamesEn[dow];
          return DayScheduleRow(
            dayOfWeek: dow,
            dayName: name,
            startTime: s?.startTime ?? '09:00:00',
            endTime: s?.endTime ?? '17:00:00',
            fromUserCache: false,
          );
        });

        _baseline = rows
            .map(
              (r) => DayScheduleRow(
                dayOfWeek: r.dayOfWeek,
                dayName: r.dayName,
                startTime: r.startTime,
                endTime: r.endTime,
                fromUserCache: r.fromUserCache,
              ),
            )
            .toList();

        emit(WorkScheduleSuccess());
      },
    );
  }

  void updateDayTimes(int dayOfWeek, {required String startTime, required String endTime}) {
    final i = rows.indexWhere((r) => r.dayOfWeek == dayOfWeek);
    if (i == -1) {
      return;
    }
    rows[i].startTime = startTime;
    rows[i].endTime = endTime;
    rows[i].fromUserCache = false;
    emit(WorkScheduleSuccess());
  }

  Future<void> saveSchedules() async {
    final userId = userCacheValue?.data?.userId ?? -1;
    if (userId == -1) {
      Utils.showToast(title: 'User not found'.tr(), state: UtilState.error);
      return;
    }

    emit(WorkScheduleUpdateLoading());

    final schedules = rows
        .map(
          (r) => WorkScheduleModel(
            dayOfWeek: r.dayOfWeek,
            startTime: r.startTime,
            endTime: r.endTime,
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
        _baseline = rows
            .map(
              (r) => DayScheduleRow(
                dayOfWeek: r.dayOfWeek,
                dayName: r.dayName,
                startTime: r.startTime,
                endTime: r.endTime,
                fromUserCache: r.fromUserCache,
              ),
            )
            .toList();
        emit(WorkScheduleUpdateSuccess());
        Utils.showToast(title: 'Work schedule updated'.tr(), state: UtilState.success);
      },
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/custom_app_bar.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/feature/menu/views/myCities/presentation/widgets/cities_save_button.dart';
import 'package:matlop_provider/feature/menu/views/myWorkTime/manager/work_schedule_cubit.dart';
import 'package:matlop_provider/feature/menu/views/myWorkTime/utils/work_schedule_time_utils.dart';

class MyWorkTimeView extends StatefulWidget {
  const MyWorkTimeView({super.key});

  @override
  State<MyWorkTimeView> createState() => _MyWorkTimeViewState();
}

class _MyWorkTimeViewState extends State<MyWorkTimeView> with SingleTickerProviderStateMixin {
  late AnimationController _fabController;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    context.read<WorkScheduleCubit>().loadSchedules().then((_) {
      if (mounted) {
        _fabController.forward();
      }
    });
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  Future<void> _pickDaySchedule(BuildContext context, DayScheduleRow row) async {
    final cubit = WorkScheduleCubit.of(context);

    final startPick = await showTimePicker(
      context: context,
      initialTime: parseApiTimeToTimeOfDay(row.startTime),
    );
    if (!context.mounted || startPick == null) {
      return;
    }

    final endPick = await showTimePicker(
      context: context,
      initialTime: parseApiTimeToTimeOfDay(row.endTime),
    );
    if (!context.mounted || endPick == null) {
      return;
    }

    cubit.updateDayTimes(
      row.dayOfWeek,
      startTime: timeOfDayToApi(startPick),
      endTime: timeOfDayToApi(endPick),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackGround,
      appBar: CustomAppBar(title: 'Work schedule'.tr()),
      body: BlocConsumer<WorkScheduleCubit, WorkScheduleState>(
        listener: (context, state) {
          if (state is WorkScheduleUpdateSuccess) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          final cubit = WorkScheduleCubit.of(context);

          if (state is WorkScheduleLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }

          if (state is WorkScheduleError) {
            return _buildError(context, state.message, cubit);
          }

          return Stack(
            children: [
              ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                itemCount: cubit.rows.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, i) {
                  final row = cubit.rows[i];
                  final range =
                      '${formatWorkTimeTo12h(row.startTime)} – ${formatWorkTimeTo12h(row.endTime)}';
                  return Material(
                    color: row.fromUserCache
                        ? AppColors.primaryColor.withValues(alpha: 0.08)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: row.fromUserCache
                            ? Border.all(color: AppColors.primaryColor, width: 1.5)
                            : null,
                      ),
                      child: ListTile(
                        selected: row.fromUserCache,
                        selectedTileColor: Colors.transparent,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        title: Text(
                          row.dayName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.cBoldTextColor,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            range,
                            style: const TextStyle(
                              color: AppColors.subTextColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        trailing: Icon(
                          row.fromUserCache ? Icons.check_circle_rounded : Icons.schedule_rounded,
                          color: AppColors.primaryColor,
                        ),
                        onTap: () => _pickDaySchedule(context, row),
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 24,
                left: 16,
                right: 16,
                child: ScaleTransition(
                  scale: _fabController,
                  child: CitiesSaveButton(
                    isLoading: state is WorkScheduleUpdateLoading,
                    hasChanges: cubit.hasChanges,
                    onSave: () => cubit.saveSchedules(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildError(BuildContext context, String message, WorkScheduleCubit cubit) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.cloud_off_rounded, size: 64, color: AppColors.cDisablePrimaryColor),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.subTextColor),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: cubit.loadSchedules,
            icon: const Icon(Icons.refresh_rounded),
            label: Text('Retry'.tr()),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }
}

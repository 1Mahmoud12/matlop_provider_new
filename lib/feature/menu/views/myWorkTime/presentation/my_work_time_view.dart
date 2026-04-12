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

  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loaded) {
      _loaded = true;
      context.read<WorkScheduleCubit>().loadSchedules(locale: context.locale.languageCode).then((_) {
        if (mounted) {
          _fabController.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
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

          final hoursLabel =
              '${formatWorkTimeTo12h(kDefaultWorkStart)} – ${formatWorkTimeTo12h(kDefaultWorkEnd)}';

          return Stack(
            children: [
              ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      hoursLabel,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.subTextColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  ...cubit.days.map(
                    (d) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () => cubit.toggleDay(d.dayOfWeek),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: d.selected,
                                  activeColor: AppColors.primaryColor,
                                  onChanged: (_) => cubit.toggleDay(d.dayOfWeek),
                                ),
                                Expanded(
                                  child: Text(
                                    d.dayName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.cBoldTextColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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

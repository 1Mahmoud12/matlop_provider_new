import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/themes/colors.dart';

/// Gradient save button shown at the bottom of the cities screen.
///
/// Disabled and grey when [hasChanges] is false. Shows a spinner when
/// [isLoading] is true.
class CitiesSaveButton extends StatelessWidget {
  final bool isLoading;
  final bool hasChanges;
  final VoidCallback onSave;

  const CitiesSaveButton({
    super.key,
    required this.isLoading,
    required this.hasChanges,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hasChanges && !isLoading ? onSave : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 52,
        decoration: BoxDecoration(
          gradient: hasChanges
              ? const LinearGradient(
                  colors: [AppColors.primaryColor, AppColors.cNewColor],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color: hasChanges ? null : AppColors.cDisablePrimaryColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: hasChanges
              ? [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : Text(
                  'Save Changes'.tr(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    letterSpacing: 0.4,
                  ),
                ),
        ),
      ),
    );
  }
}

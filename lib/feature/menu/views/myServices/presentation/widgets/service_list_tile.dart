import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/feature/menu/views/myServices/data/models/technical_service_model.dart';

class ServiceListTile extends StatelessWidget {
  final TechnicalServiceData service;
  final bool isSelected;
  final VoidCallback onTap;

  const ServiceListTile({
    super.key,
    required this.service,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Current locale context
    final isAr = context.locale.languageCode == 'ar';
    final name = isAr ? service.arName : service.enName;

    return Container(
      margin: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected
              ? AppColors.primaryColor
              : AppColors.cBorderDecoration,
          width: isSelected ? 1.5 : 1.0,
        ),
        boxShadow: [
          if (isSelected)
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                // Checkbox
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryColor : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.subTextColor.withOpacity(0.5),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, color: AppColors.white, size: 16)
                      : null,
                ),
                const SizedBox(width: 16),
                
                // Name
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                      color: AppColors.cBoldTextColor,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

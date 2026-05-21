import 'dart:io';
import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/main.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../themes/colors.dart';
import '../constants.dart';
import '../extensions.dart';
import 'app_version_data_source.dart';
void checkVersion(BuildContext context) async {
  try {
    // Get current app version
    final currentVersion = await AppVersionDataSource.getCurrentAppVersion();
    // Constants.versionApp = currentVersion; // removed
    // Fetch version info from API
    final result = await AppVersionDataSource.getAppVersion();

    result.fold(
      (failure) {
        logger.e('Failed to check app version: ${failure.errMessage}');
        // Silently fail - don't show error to user
      },
      (versionModel) async {
        // Get platform-specific version info
        final platformInfo = Platform.isAndroid ? versionModel.data.android : versionModel.data.ios;

        if (platformInfo == null) {
          logger.w('No version info available for current platform');
          return;
        }

        // Check if update is needed
        final shouldUpdate = _shouldUpdate(currentVersion, platformInfo.latestVersion);
        final needsForceUpdate = _shouldUpdate(currentVersion, platformInfo.minimumVersion);

        if (shouldUpdate || needsForceUpdate) {
          final packageInfo = await PackageInfo.fromPlatform();
          final storeUrl = platformInfo.storeUrl.isNotEmpty
              ? platformInfo.storeUrl
              : (Platform.isAndroid
                  ? 'https://play.google.com/store/apps/details?id=${packageInfo.packageName}'
                  : 'https://apps.apple.com/app/id${packageInfo.packageName}');
          if (context.mounted) {
            showDialog(
              context: context.mounted ? navigatorKey.currentState!.context : context,
              barrierColor: Colors.black87,
              barrierDismissible: !needsForceUpdate,
              builder: (context) => NewUpdate(
                  appUrl: storeUrl,
                  forceUpdate: needsForceUpdate,
                ),
            );
          }
        }
      },
    );
  } catch (e) {
    logger.e('Error checking app version: $e');
    // Silently fail - don't show error to user
  }
}

/// Compare two version strings to determine if update is needed
bool _shouldUpdate(String currentVersion, String latestVersion) {
  final versionNumbersA = currentVersion.split('.').map((e) => int.tryParse(e) ?? 0).toList();
  final versionNumbersB = latestVersion.split('.').map((e) => int.tryParse(e) ?? 0).toList();

  final int versionASize = versionNumbersA.length;
  final int versionBSize = versionNumbersB.length;
  final int maxSize = math.max(versionASize, versionBSize);

  for (int i = 0; i < maxSize; i++) {
    if ((i < versionASize ? versionNumbersA[i] : 0) > (i < versionBSize ? versionNumbersB[i] : 0)) {
      return false;
    } else if ((i < versionASize ? versionNumbersA[i] : 0) < (i < versionBSize ? versionNumbersB[i] : 0)) {
      return true;
    }
  }
  return false;
}

class NewUpdate extends StatelessWidget {
  final String appUrl;
  final bool forceUpdate;

  const NewUpdate({
    super.key,
    required this.appUrl,
    this.forceUpdate = false,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !forceUpdate,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
        insetPadding: EdgeInsets.symmetric(horizontal: 28.w),
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Teal gradient header ────────────────────────────
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 28.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryColor, AppColors.primaryColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 72.w,
                      height: 72.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withAlpha(40),
                      ),
                      child: Center(
                        child: Container(
                          width: 56.w,
                          height: 56.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withAlpha(60),
                          ),
                          child: Icon(
                            Icons.system_update_alt_rounded,
                            size: 32.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'new_updates_are_available'.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: .3,
                      ),
                    ),
                  ],
                ),
              ),

              // ── App illustration ────────────────────────────────
              Padding(
                padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                child: Column(
                  children: [
                    Icon(
                      Icons.system_update,
                      size: 80.sp,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'we_have_new_updates_for_our_app'.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              // ── Divider ─────────────────────────────────────────
              Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 24.w,
                endIndent: 24.w,
              ),

              // ── Buttons ─────────────────────────────────────────
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 20.h),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Utils.launchURLFunction(appUrl),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'update_now'.tr(),
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    if (!forceUpdate) ...[
                      SizedBox(height: 8.h),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.primaryColor,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              side: const BorderSide(color: AppColors.primaryColor),
                            ),
                          ),
                          child: Text(
                            'update_later'.tr(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

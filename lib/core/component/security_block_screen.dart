import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matlop_provider/core/themes/light.dart';
import 'package:matlop_provider/core/utils/app_images.dart';
import 'package:matlop_provider/core/utils/constants.dart';

// ─────────────────────────────────────────────
//  Enums
// ─────────────────────────────────────────────
enum BlockReason { vpn, root }

// ─────────────────────────────────────────────
//  SecurityBlockScreen  –  standalone widget
//  Usage:
//    SecurityBlockScreen(reason: BlockReason.vpn)
//    SecurityBlockScreen(reason: BlockReason.root)
// ─────────────────────────────────────────────
class SecurityBlockScreen extends StatelessWidget {
  final BlockReason reason;

  const SecurityBlockScreen({super.key, required this.reason});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'SA')],
      path: 'assets/translation',
      startLocale: const Locale('ar', 'SA'),
      child: Builder(
        builder: (ctx) => ScreenUtilInit(
          designSize: const Size(360, 840),
          minTextAdapt: true,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: ctx.localizationDelegates,
            supportedLocales: ctx.supportedLocales,
            locale: ctx.locale,
            theme: light,
            home: SecurityBlockBody(reason: reason),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Public body — use inside an existing MaterialApp
//  (no nested MaterialApp / EasyLocalization)
// ─────────────────────────────────────────────
class SecurityBlockBody extends StatelessWidget {
  final BlockReason reason;

  const SecurityBlockBody({super.key, required this.reason});

  @override
  Widget build(BuildContext context) {
    final isVpn = reason == BlockReason.vpn;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ── Teal arc header ───────────────────────────────────
          _TopArc(isVpn: isVpn),

          // ── Body ─────────────────────────────────────────────
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon badge
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9F6FC),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF33C0A8).withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      isVpn ? Icons.vpn_lock_rounded : Icons.phonelink_lock_rounded,
                      size: 38.sp,
                      color: const Color(0xFF33C0A8),
                    ),
                  ),

                  SizedBox(height: 28.h),

                  // Title
                  Text(
                    isVpn ? 'vpn_title'.tr() : 'root_title'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF2A2A2A),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: 14.h),

                  // Message
                  Text(
                    isVpn ? 'vpn_message'.tr() : 'root_message'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF787878),
                      fontSize: 14.sp,
                      height: 1.8,
                    ),
                  ),

                  SizedBox(height: 36.h),

                  // Divider with shield icon
                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: const Color(0xFFEEEEEE), thickness: 1),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Icon(Icons.shield_rounded, size: 18.sp, color: const Color(0xFF33C0A8)),
                      ),
                      Expanded(
                        child: Divider(color: const Color(0xFFEEEEEE), thickness: 1),
                      ),
                    ],
                  ),

                  SizedBox(height: 28.h),

                  // Friendly note card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6FEEC),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: const Color(0xFF33C0A8).withOpacity(0.2),
                      ),
                    ),
                    child: Text(
                      isVpn ? 'vpn_note'.tr() : 'root_note'.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF3A5F70),
                        fontSize: 13.sp,
                        height: 1.7,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Footer ────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.only(bottom: 32.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_outline_rounded, size: 13.sp, color: const Color(0xFFB4B4B4)),
                SizedBox(width: 5.w),
                Text(
                  'security_footer'.tr(),
                  style: TextStyle(color: const Color(0xFFB4B4B4), fontSize: 12.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Top arc — teal gradient same style as app
// ─────────────────────────────────────────────
class _TopArc extends StatelessWidget {
  final bool isVpn;

  const _TopArc({required this.isVpn});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _ArcClipper(),
      child: Container(
        height: 220.h,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF33C0A8), Color(0xFF0EC5D2)],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10.h),
              Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(AppImages.logoHome),
              ),
              SizedBox(height: 10.h),
              Text(
                isVpn ? 'vpn_header'.tr() : 'root_header'.tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Arc clipper
// ─────────────────────────────────────────────
class _ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 20,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_ArcClipper oldClipper) => false;
}

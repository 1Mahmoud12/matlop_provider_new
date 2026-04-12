import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/app_icons.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/feature/menu/presentation/manager/cubit/menu_cubit.dart';
import 'package:matlop_provider/feature/menu/presentation/widgets/custom_log_out_dialog.dart';
import 'package:matlop_provider/feature/menu/presentation/widgets/menu_header.dart';
import 'package:matlop_provider/feature/menu/presentation/widgets/menu_item.dart';
import 'package:matlop_provider/feature/menu/views/commonQuestions/presentation/common_questions_view.dart';
import 'package:matlop_provider/feature/menu/views/commonQuestions/presentation/manager/cubit/faq_cubit.dart';
import 'package:matlop_provider/feature/menu/views/myCities/manager/cities_cubit.dart';
import 'package:matlop_provider/feature/menu/views/myCities/presentation/my_cities_view.dart';
import 'package:matlop_provider/feature/menu/views/myServices/manager/services_cubit.dart';
import 'package:matlop_provider/feature/menu/views/myServices/presentation/my_services_view.dart';
import 'package:matlop_provider/feature/menu/views/myWorkTime/manager/work_schedule_cubit.dart';
import 'package:matlop_provider/feature/menu/views/myWorkTime/presentation/my_work_time_view.dart';
import 'package:matlop_provider/feature/menu/views/privacy&policy/presentation/manager/cubit/privacy_and_policy_cubit.dart';
import 'package:matlop_provider/feature/menu/views/privacy&policy/presentation/privacy_and_policy_view.dart';
import 'package:matlop_provider/feature/menu/views/settings/presentation/settings_view.dart';
import 'package:matlop_provider/feature/menu/views/termsAndConditions/presentation/manager/cubit/term_and_conditions_cubit.dart';
import 'package:matlop_provider/feature/menu/views/termsAndConditions/presentation/term_and_conditions_view.dart';
import 'package:matlop_provider/feature/menu/views/wallet/presentation/wallet_view.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                const MenuHeader(),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  // height: 0.5,
                  thickness: 0.5,
                  color: AppColors.primaryColor.withOpacity(0.2),
                ),
                MenuItem(
                  icon: AppIcons.wallet,
                  text: 'My Wallet'.tr(),
                  onTap: () {
                    context.navigateToPage(const WalletView());
                  },
                ),
                MenuItem(
                  icon: AppIcons.global,
                  text: 'My Services'.tr(),
                  onTap: () {
                    context.navigateToPage(
                      BlocProvider(
                        create: (_) => ServicesCubit(),
                        child: const MyServicesView(),
                      ),
                    );
                  },
                ),
                MenuItem(
                  icon: AppIcons.global,
                  text: 'My Cities'.tr(),
                  onTap: () {
                    context.navigateToPage(
                      BlocProvider(
                        create: (_) => CitiesCubit(),
                        child: const MyCitiesView(),
                      ),
                    );
                  },
                ),
                MenuItem(
                  icon: AppIcons.schedule,
                  text: 'Work schedule'.tr(),
                  onTap: () {
                    context.navigateToPage(
                      BlocProvider(
                        create: (_) => WorkScheduleCubit(),
                        child: const MyWorkTimeView(),
                      ),
                    );
                  },
                ),
                MenuItem(
                  icon: AppIcons.setting,
                  text: 'Settings'.tr(),
                  onTap: () {
                    context.navigateToPage(const SettingsView());
                  },
                ),
                MenuItem(
                  icon: AppIcons.global,
                  text: 'Share the App'.tr(),
                  onTap: MenuCubit.of(context).shareApp,
                ),
        
                MenuItem(
                  icon: AppIcons.commonQuestion,
                  text: 'FAQ'.tr(),
                  onTap: () {
                    context.navigateToPage(
                      BlocProvider(
                        create: (context) => FaqCubit(),
                        child: const CommonQuestions(),
                      ),
                    );
                  },
                ),
                MenuItem(
                  icon: AppIcons.privacy,
                  text: 'Privacy Policy'.tr(),
                  onTap: () {
                    context.navigateToPage(
                      BlocProvider(
                        create: (context) => PrivacyAndPolicyCubit(),
                        child: const PrivacyAndPolicyView(),
                      ),
                    );
                  },
                ),
                MenuItem(
                  icon: AppIcons.rule,
                  text: 'Terms and Conditions'.tr(),
                  onTap: () {
                    context.navigateToPage(
                      BlocProvider(
                        create: (context) => TermAndConditionsCubit(),
                        child: const TermAndConditionsView(),
                      ),
                    );
                  },
                ),
                MenuItem(
                  icon: AppIcons.contactUs,
                  text: 'Contact Us'.tr(),
                  onTap: MenuCubit.of(context).whatsapp,
                ),
                MenuItem(
                  color: Colors.red.withOpacity(0.15),
                  icon: AppIcons.logoutIcon,
                  text: 'Log Out'.tr(),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const CustomLogoutDialog();
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 150,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

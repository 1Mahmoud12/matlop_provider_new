import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/custom_app_bar.dart';
import 'package:matlop_provider/core/utils/app_icons.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/feature/menu/presentation/widgets/menu_item.dart';
import 'package:matlop_provider/feature/menu/views/myCities/manager/cities_cubit.dart';
import 'package:matlop_provider/feature/menu/views/myCities/presentation/my_cities_view.dart';
import 'package:matlop_provider/feature/menu/views/settings/presentation/widgets/delete_account_bottom_sheet.dart';
import 'package:matlop_provider/feature/menu/views/settings/presentation/widgets/selected_language_dialog.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Setting'.tr(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            MenuItem(
              icon: AppIcons.location,
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
              icon: AppIcons.wallet,
              text: 'Language'.tr(),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    const int selectedValue = 0;

                    return const SelectLanguageDialog(selectedIndex: selectedValue);
                  },
                );
              },
            ),
            MenuItem(
              icon: AppIcons.wallet,
              text: 'Notification'.tr(),
              onTap: () {
                setState(() {
                  isSwitched = !isSwitched;
                });
              },
              suffixWidget: Center(
                child: Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                  activeTrackColor: Colors.teal.withOpacity(0.7),
                  activeColor: Colors.white,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey.withOpacity(0.2),
                ),
              ),
            ),
            MenuItem(
              color: Colors.red.withOpacity(0.15),
              icon: AppIcons.logoutIcon,
              text: 'Delete account'.tr(),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const DeleteAccountDialog();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

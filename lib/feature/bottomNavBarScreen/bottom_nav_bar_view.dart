import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/core/utils/notification/notification.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/bottomNavBarScreen/presentation/manager/cubit/bottom_nav_bar_cubit.dart';
import 'package:matlop_provider/feature/bottomNavBarScreen/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:matlop_provider/feature/order/presentation/manager/cubit/order_cubit.dart'; // Add this to exit the app

class BottomNavBarView extends StatefulWidget {
  const BottomNavBarView({super.key, this.selectedIndex = 0});

  final int selectedIndex;

  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {
  late int _selectedIconIndex;
  DateTime? _lastPressedAt;

  @override
  void initState() {
    OrderCubit.of(context).getOrderByStatus(context, status: 7);
    _selectedIconIndex = widget.selectedIndex;
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        userCache?.put(languageKey, context.locale.languageCode == 'ar');
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Check if the user presses the back button twice within 2 seconds
        if (_lastPressedAt == null || DateTime.now().difference(_lastPressedAt!) > const Duration(seconds: 2)) {
          // Record the time of the first press
          _lastPressedAt = DateTime.now();
          // Show a toast message prompting the user to press again to exit
          Utils.showToast(title: 'Click again to exit', state: UtilState.success);
          return false;
        }
        // If the user presses again within 2 seconds, exit the app
        if (Platform.isAndroid) {
          exit(0); // Exit the app on Android
        } else if (Platform.isIOS) {
          return true;
        }
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            BottomNavBarCubit.of(context).screenList[_selectedIconIndex],
            CustomBottomNavBar(
              selectedIconIndex: _selectedIconIndex,
              onIconTapped: (index) {
                if (index == 2) {
                  // context.navigateToPage(
                  //   // const MessagesScreen(
                  //   //   uuid: '',
                  //   // ),
                  // );
                }
                setState(() {
                  _selectedIconIndex = index;
                });
              },
              screenList: BottomNavBarCubit.of(context).screenList,
            ),
          ],
        ),
      ),
    );
  }
}

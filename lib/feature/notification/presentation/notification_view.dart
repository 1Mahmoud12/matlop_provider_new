import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/buttons/arrow_back_button.dart';
import 'package:matlop_provider/core/utils/app_images.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/feature/notification/data/models/fire_notification_model.dart';
import 'package:matlop_provider/feature/notification/presentation/manager/notificationCubit/cubit.dart';
import 'package:matlop_provider/feature/notification/presentation/widgets/notification_item.dart';

class NotificationView extends StatefulWidget {
  final NotificationCubit cubit;

  const NotificationView({super.key, required this.cubit});

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => widget.cubit.getNotification(context),
    );
    //  widget.cubit.getNotification(context);
  }

  void _onDismissNotification(int index) {
    widget.cubit.readNotification(context, index);
    // setState(() {
    //   notifications.removeAt(index);
    // });
    // if (notifications.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('No notifications available')),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'.tr()),
        leading: const FittedBox(
          fit: BoxFit.scaleDown,
          child: ArrowBackButton(),
        ),
      ),
      body: BlocProvider.value(
        value: widget.cubit,
        child: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) => ConstantModel.notificationModel != null &&
                  ConstantModel.notificationModel!.data != null &&
                  ConstantModel.notificationModel!.data!.data != null &&
                  ConstantModel.notificationModel!.data!.data!.isNotEmpty
              ? ListView(
                  children: [
                    const SizedBox(height: 20),
                    ...ConstantModel.notificationModel!.data!.data!.map((notification) {
                      final ItemNotificationModel index = notification;
                      return Dismissible(
                        key: Key(index.notificationId.toString()),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          _onDismissNotification(index.notificationId!);
                        },
                        child: NotificationItem(
                          notification: index,
                          onDismiss: () => _onDismissNotification(index.notificationId!),
                        ),
                      );
                    }),
                  ],
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Image.asset(
                      context.locale.languageCode == 'en' ? AppImages.thereIsNoNotificationEn : AppImages.thereIsNoNotificationAr,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

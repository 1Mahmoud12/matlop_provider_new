import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/app_icons.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/feature/notification/data/models/fire_notification_model.dart';

class NotificationItem extends StatelessWidget {
  final ItemNotificationModel notification;

  final Function onDismiss; // Callback to notify parent when dismissed

  const NotificationItem({
    super.key,
    required this.onDismiss,
    required this.notification, // Passing the callback
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(notification.notificationId.toString()),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        onDismiss();
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('Notification dismissed')),
        // );
        return false;
      },
      background: Container(
        margin: const EdgeInsets.symmetric(horizontal: 13),
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: const Icon(Icons.remove_red_eye, color: Colors.white),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: notification.isSeen ?? true ? Colors.transparent : AppColors.primaryColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(AppIcons.verifyIcon),
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          (context.locale.languageCode == 'en' ? notification.titleEn : notification.titleAr) ?? Constants.unKnownValue,
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14.sp),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      if (notification.creationTime != null)
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              DateFormat('MMMM dd').format(DateTime.parse(notification.creationTime!)),
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Text(
                    (context.locale.languageCode == 'en' ? notification.bodyEn : notification.bodyAr) ?? Constants.unKnownValue,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14.sp, color: AppColors.textColor, fontWeight: FontWeight.w300),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

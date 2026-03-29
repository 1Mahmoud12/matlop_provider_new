import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matlop_provider/core/utils/app_icons.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/feature/notification/presentation/manager/notificationCubit/cubit.dart';
import 'package:matlop_provider/feature/notification/presentation/notification_view.dart';

class NotificationIcon extends StatefulWidget {
  const NotificationIcon({
    super.key,
  });

  @override
  State<NotificationIcon> createState() => _NotificationIconState();
}

class _NotificationIconState extends State<NotificationIcon> {
  late final NotificationCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = NotificationCubit();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        cubit.getNotification(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.navigateToPage(NotificationView(
          cubit: cubit,
        ));
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: SvgPicture.asset(
              AppIcons.notification,
              colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            ),
          ),
          BlocProvider.value(
            value: cubit,
            child: BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) => cubit.countUnReadNotification != 0
                  ? Positioned(
                      top: 0,
                      right: 2,
                      child: Container(
                        height: 12,
                        width: 12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffEB7D7D),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}

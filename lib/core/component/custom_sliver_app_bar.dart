import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/component/buttons/arrow_back_button.dart';
import 'package:matlop_provider/core/themes/colors.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
    required this.forceElevated,
    this.arrowBack = false,
  });
  final bool arrowBack;
  final bool forceElevated;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 75,
      forceMaterialTransparency: true,
      pinned: true,
      floating: true,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.transparent,
      forceElevated: forceElevated,
      flexibleSpace: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff06B396), Color(0xff20D4AD)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              //  stops: [0.1, 1],
            ),
          ),
          child: Row(
            children: [
              if (arrowBack)
                const ArrowBackButton(
                  borderColor: Colors.white,
                  iconColor: Colors.white,
                  backgroundColor: Colors.transparent,
                ),
              const SizedBox(width: 20),
              Center(
                child: Text(
                  'Order'.tr(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

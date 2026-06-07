import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AllOffersHeader extends StatelessWidget {
  const AllOffersHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      padding: const EdgeInsets.all(10),
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
      child: Text(
        'All available offers'.tr(),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
      ),
    );
  }
}

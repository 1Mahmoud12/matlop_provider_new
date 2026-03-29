import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WalletSmallCard extends StatelessWidget {
  const WalletSmallCard({
    super.key,
    required this.text,
    required this.icon,
  });
  final String text;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: const Color(0xff0CC4CD),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          SvgPicture.asset(icon),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

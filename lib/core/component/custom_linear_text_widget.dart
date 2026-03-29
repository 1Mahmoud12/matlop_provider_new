import 'package:flutter/material.dart';

class CustomLinearTextWidget extends StatelessWidget {
  const CustomLinearTextWidget({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Color(0xff33C0A8), Color(0xff37EFC7)],
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
      ).createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}

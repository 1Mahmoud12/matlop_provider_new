import 'package:flutter/material.dart';

class CityWidget extends StatelessWidget {
  const CityWidget({
    super.key,
    required this.text, this.onTap,
  });

  final String text;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}

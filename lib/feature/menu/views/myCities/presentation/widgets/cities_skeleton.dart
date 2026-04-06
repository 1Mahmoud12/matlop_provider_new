import 'package:flutter/material.dart';
import 'package:matlop_provider/core/themes/colors.dart';

/// Animated shimmer skeleton shown while cities are loading.
class CitiesSkeleton extends StatefulWidget {
  const CitiesSkeleton({super.key});

  @override
  State<CitiesSkeleton> createState() => _CitiesSkeletonState();
}

class _CitiesSkeletonState extends State<CitiesSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.35, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        itemCount: 8,
        itemBuilder: (_, __) => Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.cDate,
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}

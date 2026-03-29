import 'package:flutter/material.dart';
import 'package:matlop_provider/core/utils/app_images.dart';

class ServerErrorWidget extends StatelessWidget {
  const ServerErrorWidget({
    super.key,
    this.height,
    this.width,
    this.data,
  });
  final double? height;
  final double? width;
  final String? data;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: height ?? 200,
            width: width ?? 200,
            child: Image.asset(
              AppImages.somethingwentwrong,
            ),
          ),
          Text(data ?? 'Something went wrong please try again later :('),
        ],
      ),
    );
  }
}

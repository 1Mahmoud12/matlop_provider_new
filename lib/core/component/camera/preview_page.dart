import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/component/custom_app_bar.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/app_images.dart';
import 'package:matlop_provider/core/utils/extensions.dart';
import 'package:share_plus/share_plus.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({super.key, this.pictureFile, this.pictureUrl});

  final XFile? pictureFile;
  final String? pictureUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Preview Picture'),
      backgroundColor: AppColors.scaffoldBackGround,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Center(
          child: pictureFile != null && pictureFile!.path != ''
              ? Image.file(
                  File(pictureFile!.path),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => SizedBox(
                    width: context.screenWidth * .8,
                    height: context.screenHeight * .5,
                    child: Column(
                      children: [
                        Image.asset(
                          AppImages.somethingwentwrong,
                        ),
                      ],
                    ),
                  ),
                )
              : CachedNetworkImage(
                  imageUrl: pictureUrl!,
                  errorWidget: (context, url, error) => SizedBox(
                    width: context.screenWidth * .8,
                    height: context.screenHeight * .5,
                    child: Column(
                      children: [
                        Image.asset(
                          AppImages.somethingwentwrong,
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

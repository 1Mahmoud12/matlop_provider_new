
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/utils/app_images.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: 'https://example.com/user_profile_image.jpg',
        height: 50,
        width: 50,
        fit: BoxFit.cover,
        placeholder: (context, url) => SizedBox(
          height: 30,
          width: 30,
          child: Image.asset(
            AppImages.loadingIndicator,
          ),
        ),
        errorWidget: (context, url, error) => const Icon(
          Icons.error,
          color: Colors.red,
        ),
      ),
    );
  }
}

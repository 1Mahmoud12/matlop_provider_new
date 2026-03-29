import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemImage extends StatelessWidget {
  const ItemImage({
    super.key,
    required this.image,
    this.dynamicHeight = false,
    this.width,
    this.decoration,
    this.padding,
  });

  final String image;
  final bool dynamicHeight;
  final double? width;
  final Decoration? decoration;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: const EdgeInsets.only(top: 3),
      width: width ?? 80,
      height: dynamicHeight ? null : 90,
      decoration: decoration,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: CachedNetworkImage(
          imageUrl: image,
          placeholder: (context, url) => const SizedBox(
            height: 40,
            width: 40,
            child: FittedBox(child: CircularProgressIndicator()),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error), // Shows an error icon if the image fails to load
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

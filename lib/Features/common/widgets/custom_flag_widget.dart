import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';

import 'custom_circular_indicator.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final bool isCircle;
  final String? defaultImage;
  const CustomNetworkImage({
    Key? key,
    required this.imageUrl,
    this.isCircle = false,
    this.defaultImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 24,
      child: ClipRRect(
        borderRadius: isCircle
            ? const BorderRadius.all(Radius.circular(12))
            : BorderRadius.zero,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: isCircle ? BoxFit.fill : null,
          placeholder: (context, url) => Container(
            margin: const EdgeInsets.all(2),
            child: const Center(
              child: CustomCircularProgressIndicator(
                size: 16,
              ),
            ),
          ),
          errorWidget: (context, url, error) => Image.asset(imageUrl),
        ),
      ),
    );
  }
}

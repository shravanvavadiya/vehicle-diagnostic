import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/utils/assets.dart';

class CustomCachedImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;

  const CustomCachedImage(
      {super.key,
      required this.imageUrl,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => const Icon(Icons.image),
      errorWidget: (context, url, error) {
        return const Icon(Icons.error_outline);
      },
    );
  }
}

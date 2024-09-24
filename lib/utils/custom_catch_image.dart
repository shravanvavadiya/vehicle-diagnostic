import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/utils/assets.dart';

class CustomCachedImage extends StatelessWidget {
  final String imageUrl;
  final Widget? placeHolder;
  final Widget? errorWidget;
  final double height;
  final double width;

  const CustomCachedImage(
      {super.key,
      required this.imageUrl,
      required this.height,
       this.placeHolder,
       this.errorWidget,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => placeHolder ?? Image.asset(
        ImagesAsset.user,
        height: 20,
      ),
      errorWidget: (context, url, error) {
        return errorWidget??Image.asset(
          ImagesAsset.user,
          height: 20,
        );
      },
    );
  }
}

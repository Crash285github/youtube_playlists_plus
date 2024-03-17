import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ytp_new/config.dart';

class Thumbnail extends StatelessWidget {
  final String thumbnail;
  final double height, width;
  final BorderRadiusGeometry? borderRadius;

  const Thumbnail({
    super.key,
    required this.thumbnail,
    required this.height,
    required this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) => Container(
        height: height,
        width: height,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: CachedNetworkImage(
          imageUrl: thumbnail,
          fit: BoxFit.cover,
          memCacheHeight: height * MediaQuery.devicePixelRatioOf(context) ~/ 1,
          fadeInDuration: AppConfig.defaultAnimationDuration,
          errorWidget: (_, __, ___) => const Center(
            child: Icon(Icons.warning_amber_rounded),
          ),
        ),
      );
}

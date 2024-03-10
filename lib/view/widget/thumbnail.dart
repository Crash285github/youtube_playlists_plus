import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Thumbnail extends StatelessWidget {
  final String thumbnail;
  final double height, width;

  const Thumbnail({
    super.key,
    required this.thumbnail,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) => Container(
        height: height,
        width: height,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: CachedNetworkImage(
          imageUrl: thumbnail,
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 200),
          errorWidget: (_, __, ___) => const Center(
            child: Icon(Icons.warning_amber_rounded),
          ),
        ),
      );
}

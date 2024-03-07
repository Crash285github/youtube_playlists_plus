import 'package:flutter/material.dart';

class Thumbnail extends StatelessWidget {
  final String thumbnail;
  final double height;
  final double width;
  const Thumbnail({
    super.key,
    required this.thumbnail,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: height,
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        thumbnail,
        fit: BoxFit.cover,
      ),
    );
  }
}

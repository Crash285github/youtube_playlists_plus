import 'package:flutter/material.dart';
import 'package:ytp_new/view/widget/adaptive_secondary.dart';

class MediaItemTemplate extends StatelessWidget {
  final void Function(Offset offset)? onTap;
  final void Function(Offset offset)? onSecondary;
  final BorderRadiusGeometry? borderRadius;
  final Widget? child;
  const MediaItemTemplate({
    super.key,
    this.onTap,
    this.onSecondary,
    this.borderRadius,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(16.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: AdaptiveSecondaryInkWell(
        onTap: onTap,
        onSecondary: onSecondary,
        child: child,
      ),
    );
  }
}

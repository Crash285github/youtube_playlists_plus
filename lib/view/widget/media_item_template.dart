import 'package:flutter/material.dart';
import 'package:ytp_new/view/widget/adaptive_secondary.dart';

class MediaItem extends StatelessWidget {
  final void Function(Offset offset)? primaryAction;
  final void Function(Offset offset)? secondaryAction;
  final BorderRadiusGeometry? borderRadius;
  final Widget? child;
  const MediaItem({
    super.key,
    this.primaryAction,
    this.secondaryAction,
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
        onPrimary: primaryAction,
        onSecondary: secondaryAction,
        overlayColor: MaterialStatePropertyAll(
          Theme.of(context).colorScheme.primary.withOpacity(.2),
        ),
        child: child,
      ),
    );
  }
}

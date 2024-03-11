import 'dart:io';

import 'package:flutter/material.dart';

class AdaptiveSecondaryInkWell extends StatelessWidget {
  final void Function(Offset offset)? onSecondary;
  final void Function(Offset offset)? onTap;
  final BorderRadius? borderRadius;
  final MaterialStateProperty<Color?>? overlayColor;
  final Widget? child;

  const AdaptiveSecondaryInkWell({
    super.key,
    this.onTap,
    this.onSecondary,
    this.child,
    this.borderRadius,
    this.overlayColor,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onSecondaryTapUp: Platform.isWindows
            ? (details) {
                if (onSecondary != null) {
                  onSecondary!(details.globalPosition);
                }
              }
            : null,
        onLongPressStart: Platform.isAndroid
            ? (details) {
                if (onSecondary != null) {
                  onSecondary!(details.globalPosition);
                }
              }
            : null,
        child: InkWell(
          onTap: () {},
          borderRadius: borderRadius,
          overlayColor: overlayColor,
          onTapUp: onTap == null
              ? null
              : (details) => onTap!(details.globalPosition),
          child: child,
        ),
      );
}

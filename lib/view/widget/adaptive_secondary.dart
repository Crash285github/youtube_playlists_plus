import 'dart:io';

import 'package:flutter/material.dart';

class AdaptiveSecondaryInkWell extends StatelessWidget {
  final void Function(Offset offset)? onSecondary;
  final void Function(Offset offset)? onPrimary;
  final BorderRadius? borderRadius;
  final MaterialStateProperty<Color?>? overlayColor;
  final Widget? child;

  const AdaptiveSecondaryInkWell({
    super.key,
    this.onPrimary,
    this.onSecondary,
    this.child,
    this.borderRadius,
    this.overlayColor,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isWindows) {
      return InkWell(
        borderRadius: borderRadius,
        overlayColor: overlayColor,
        onSecondaryTap: () {},
        onTap: () {},
        onSecondaryTapUp: onSecondary == null
            ? null
            : (details) => onSecondary!(details.globalPosition),
        onTapUp: onPrimary == null
            ? null
            : (details) => onPrimary!(details.globalPosition),
        child: child,
      );
    }

    return GestureDetector(
      onLongPressStart: onSecondary == null
          ? null
          : (details) => onSecondary!(details.globalPosition),
      child: InkWell(
        borderRadius: borderRadius,
        overlayColor: overlayColor,
        onTap: () {},
        onTapUp: onPrimary == null
            ? null
            : (details) => onPrimary!(details.globalPosition),
        child: child,
      ),
    );
  }
}

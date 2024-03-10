import 'dart:io';

import 'package:flutter/material.dart';

class AdaptiveSecondaryInkWell extends StatelessWidget {
  final void Function(Offset offset)? onSecondary;
  final void Function(Offset offset)? onTap;
  final Widget? child;

  const AdaptiveSecondaryInkWell({
    super.key,
    this.onTap,
    this.onSecondary,
    this.child,
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
          onTapUp: onTap == null
              ? null
              : (details) => onTap!(details.globalPosition),
          child: child,
        ),
      );
}

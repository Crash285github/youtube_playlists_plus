import 'dart:io';

import 'package:flutter/material.dart';

class AdaptiveSecondary extends StatelessWidget {
  final void Function(Offset offset)? secondary;
  final Widget? child;

  const AdaptiveSecondary({
    super.key,
    this.secondary,
    this.child,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onSecondaryTapUp: Platform.isWindows
            ? (details) {
                if (secondary != null) {
                  secondary!(details.globalPosition);
                }
              }
            : null,
        onLongPressStart: Platform.isAndroid
            ? (details) {
                if (secondary != null) {
                  secondary!(details.globalPosition);
                }
              }
            : null,
        child: InkWell(
          onTap: () {},
          child: child,
        ),
      );
}

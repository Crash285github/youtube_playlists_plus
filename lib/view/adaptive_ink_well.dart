import 'dart:io';

import 'package:flutter/material.dart';

class AdaptiveSecondary extends StatelessWidget {
  final Widget? child;
  final void Function(Offset offset)? secondary;
  const AdaptiveSecondary({
    super.key,
    this.child,
    this.secondary,
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

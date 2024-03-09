import 'package:flutter/material.dart';

class SettingTemplate extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? onLongPress;
  final void Function(TapUpDetails)? onTapUp;
  final Widget child;
  const SettingTemplate({
    super.key,
    this.onTap,
    this.onLongPress,
    this.onTapUp,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onTapUp: onTapUp,
      onLongPress: onLongPress,
      child: SizedBox(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ),
      ),
    );
  }
}

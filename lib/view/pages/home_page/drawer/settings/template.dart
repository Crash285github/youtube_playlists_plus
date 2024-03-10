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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        overlayColor: MaterialStatePropertyAll(
          Theme.of(context).colorScheme.primary.withOpacity(.3),
        ),
        onTap: onTap,
        onTapUp: onTapUp,
        onLongPress: onLongPress,
        child: SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DefaultTextStyle(
                style: Theme.of(context).textTheme.bodyLarge!, child: child),
          ),
        ),
      ),
    );
  }
}

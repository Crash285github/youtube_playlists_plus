part of '../preferences_drawer.dart';

class _SettingTemplate extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? onLongPress;
  final void Function(TapUpDetails)? onTapUp;
  final Widget child;
  const _SettingTemplate({
    this.onTap,
    this.onLongPress,
    this.onTapUp,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 8.0, top: 2.0, bottom: 2.0),
        child: InkWell(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
          ),
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
                style: Theme.of(context).textTheme.bodyLarge!,
                child: child,
              ),
            ),
          ),
        ),
      );
}

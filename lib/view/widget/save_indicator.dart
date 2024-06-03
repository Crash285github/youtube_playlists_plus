import 'package:flutter/material.dart';
import 'package:ytp_new/config.dart';

class SaveIndicator {
  static OverlayEntry? _overlayEntry;

  /// Flashes the Save Indicator for a short duration
  static void flash([
    final Duration duration = const Duration(milliseconds: 500),
  ]) {
    _overlayEntry?.remove();
    _overlayEntry = null;

    _overlayEntry = OverlayEntry(
      builder: (context) => _SaveIndicatorWidget(duration),
    );

    Overlay.of(AppConfig.mainNavigatorKey.currentContext!)
        .insert(_overlayEntry!);
  }
}

class _SaveIndicatorWidget extends StatefulWidget {
  final Duration duration;
  const _SaveIndicatorWidget(this.duration);

  @override
  State<_SaveIndicatorWidget> createState() => _SaveIndicatorWidgetState();
}

class _SaveIndicatorWidgetState extends State<_SaveIndicatorWidget> {
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() => _isVisible = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) => Positioned(
        bottom: 8.0,
        right: 8.0,
        child: IgnorePointer(
          child: AnimatedOpacity(
            duration: widget.duration,
            opacity: _isVisible ? 1.0 : 0.0,
            child: const Icon(
              Icons.save,
              color: Colors.blue,
            ),
          ),
        ),
      );
}

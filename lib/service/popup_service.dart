import 'package:flutter/material.dart';

/// Handles Popups
class PopupService {
  /// Shows a context menu
  static Future<T?> contextMenu<T>({
    required BuildContext context,
    required Offset offset,
    required List<PopupMenuEntry<T>> items,
  }) async =>
      showMenu<T>(
        context: context,
        position: RelativeRect.fromLTRB(
          offset.dx,
          offset.dy,
          MediaQuery.of(context).size.width - offset.dx,
          0,
        ),
        elevation: 5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        clipBehavior: Clip.antiAlias,
        useRootNavigator: true,
        items: items,
      );

  /// Shows an [AlertDialog]
  static Future<T?> dialog<T>({
    required BuildContext context,
    required Widget child,
    required List<Widget> actions,
  }) async =>
      showDialog<T>(
        useRootNavigator: false,
        context: context,
        builder: (context) => AlertDialog(
          content: child,
          actions: actions,
        ),
      );
}

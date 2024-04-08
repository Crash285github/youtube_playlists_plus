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
    required List<Widget> actions,
    required Widget child,
  }) async =>
      showDialog<T>(
        useRootNavigator: false,
        context: context,
        builder: (context) => AlertDialog(
          content: child,
          actions: actions,
        ),
      );

  static Future<bool?> confirmDialog({
    required BuildContext context,
    String confirmText = "Proceed",
    String cancelText = "Cancel",
    required Widget child,
  }) =>
      dialog<bool>(
        context: context,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(confirmText),
          ),
        ],
        child: child,
      );

  static void showError({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }
}

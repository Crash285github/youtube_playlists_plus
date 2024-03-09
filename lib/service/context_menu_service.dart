import 'package:flutter/material.dart';

class ContextMenuService {
  static Future<T?> show<T>({
    required BuildContext context,
    required Offset offset,
    required List<PopupMenuEntry<T>> items,
    bool separateFirst = false,
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
}

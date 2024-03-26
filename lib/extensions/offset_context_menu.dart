part of extensions;

extension OffsetContextMenu on Offset {
  /// Shows a context menu at the given offset
  Future<T?> showContextMenu<T>({
    required BuildContext context,
    required List<PopupMenuEntry<T>> items,
  }) async =>
      await PopupService.contextMenu(
        context: context,
        offset: this,
        items: items,
      );
}

part of extensions;

extension ToClipboard on String {
  /// Copies a String to the clipboard
  Future copyToClipboard() async =>
      await Clipboard.setData(ClipboardData(text: this));
}

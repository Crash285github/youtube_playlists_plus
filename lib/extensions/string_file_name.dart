extension ToFileName on String {
  /// Removed characters that are not valid in a File and replaces them with '_'
  String toFileName() =>
      replaceAll(RegExp('[<>*|?":/]'), '_').replaceAll('\\', '_');
}

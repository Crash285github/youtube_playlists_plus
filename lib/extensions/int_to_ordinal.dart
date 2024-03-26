part of extensions;

extension ToOrdinal on int {
  String toOrdinalString() {
    if (this % 100 == 11) return "$this" "th";
    if (this % 100 == 12) return "$this" "th";
    if (this % 100 == 13) return "$this" "th";

    if (this % 10 == 1) return "$this" "st";
    if (this % 10 == 2) return "$this" "nd";
    if (this % 10 == 3) return "$this" "rd";

    return "$this" "th";
  }
}

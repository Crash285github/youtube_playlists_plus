part of extensions;

extension TimeAgo on DateTime {
  /// Shows how long ago a `DateTime` was
  String timeago() => time_ago.format(this);
}

import 'package:timeago/timeago.dart' as tm;

extension TimeAgo on DateTime {
  /// Shows how long ago a `DateTime` was
  String timeago() => tm.format(this);
}

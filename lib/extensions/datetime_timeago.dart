import 'package:timeago/timeago.dart' as tm;

extension TimeAgo on DateTime {
  String timeago() => tm.format(this);
}

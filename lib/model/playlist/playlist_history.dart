import 'package:ytp_new/model/video/video_history.dart';

mixin PlaylistHistory {
  final List<VideoHistory> savedHistory = [];
  final List<VideoHistory> pendingHistory = [];

  List<VideoHistory> get history => (savedHistory + pendingHistory)
    ..sort((a, b) => a.created.compareTo(b.created));

  void applyPendingHistory() {
    savedHistory.addAll(pendingHistory);
    pendingHistory.clear();
  }

  bool removeHistory(VideoHistory history) =>
      savedHistory.remove(history) || pendingHistory.remove(history);
}

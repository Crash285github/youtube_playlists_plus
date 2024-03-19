import 'package:flutter/material.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/model/video/video_history.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/view/widget/fading_listview.dart';
import 'package:ytp_new/view/pages/playlist_page/tabs/history/history_item.dart';

class PlaylistPageTabHistory extends StatefulWidget {
  final String playlistId;
  const PlaylistPageTabHistory({super.key, required this.playlistId});

  @override
  State<PlaylistPageTabHistory> createState() => _PlaylistPageTabHistoryState();
}

class _PlaylistPageTabHistoryState extends State<PlaylistPageTabHistory>
    with AutomaticKeepAliveClientMixin {
  Playlist get playlist => PlaylistStorageProvider().fromId(widget.playlistId)!;

  List<VideoHistory> get history => playlist.history;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return history.isEmpty
        ? const Center(child: Text("No history."))
        : FadingListView(
            gradientHeight: 50,
            bottom: false,
            padding: const EdgeInsets.only(bottom: 80),
            itemBuilder: (context, index) => HistoryItem(
              playlistId: widget.playlistId,
              history: history[index],
              isFirst: index == 0,
              isLast: index == history.length - 1,
            ),
            itemCount: history.length,
          );
  }

  @override
  bool get wantKeepAlive => mounted;
}

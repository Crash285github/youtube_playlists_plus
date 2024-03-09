import 'package:flutter/material.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/model/video/video_history.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/view/fading_listview.dart';
import 'package:ytp_new/view/pages/playlist_page/tabs/history/history_item.dart';

class PlaylistPageTabHistory extends StatelessWidget {
  final String playlistId;
  final List<VideoHistory> history;
  const PlaylistPageTabHistory(
      {super.key, required this.history, required this.playlistId});

  Playlist get playlist => PlaylistStorageProvider().fromId(playlistId)!;

  @override
  Widget build(BuildContext context) => history.isEmpty
      ? const Center(child: Text("No history."))
      : FadingListView(
          gradientHeight: 50,
          bottom: false,
          padding: const EdgeInsets.only(bottom: 80),
          itemBuilder: (context, index) => HistoryItem(
            playlistId: playlistId,
            history: history[index],
          ),
          itemCount: history.length,
        );
}

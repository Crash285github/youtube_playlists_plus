import 'package:flutter/material.dart';
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
            gradientHeight: 70,
            bottom: false,
            padding: const EdgeInsets.only(bottom: 80, top: 20),
            itemBuilder: (context, index) {
              bool first = true;
              bool last = true;
              try {
                last = history[index]
                        .created
                        .difference(history[index + 1].created)
                        .inMilliseconds >
                    1;
              } catch (_) {}

              try {
                first = history[index - 1]
                        .created
                        .difference(history[index].created)
                        .inSeconds >
                    1;
              } catch (_) {}

              return Padding(
                padding: EdgeInsets.only(
                  top: first ? 4.0 : 0,
                  bottom: last ? 4.0 : 0,
                ),
                child: HistoryItem(
                  playlistId: widget.playlistId,
                  history: history[index],
                  isFirst: first,
                  isLast: last,
                ),
              );
            },
            itemCount: history.length,
          );
  }

  @override
  bool get wantKeepAlive => mounted;
}

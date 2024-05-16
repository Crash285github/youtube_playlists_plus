import 'package:flutter/material.dart';
import 'package:ytp_new/extensions/extensions.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/view/widget/fading_listview.dart';
import 'package:ytp_new/view/pages/playlist_page/tabs/history/history_item.dart';

class HistoryTab extends StatefulWidget {
  final String playlistId;
  final ScrollController scrollController;
  const HistoryTab({
    super.key,
    required this.playlistId,
    required this.scrollController,
  });

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab>
    with AutomaticKeepAliveClientMixin {
  Playlist get playlist => PlaylistStorageProvider().fromId(widget.playlistId)!;

  List<VideoHistory> get history => playlist.history;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return history.isEmpty
        ? Center(
            child: Text(
              "No history.",
              style: Theme.of(context).textTheme.labelLarge!.withOpacity(.5),
            ),
          )
        : FadingListView(
            gradientHeight: 70,
            bottom: false,
            controller: widget.scrollController,
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

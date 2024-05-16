import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/extensions/extensions.dart';
import 'package:ytp_new/provider/anchor_storage_provider.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/view/pages/playlist_page/tabs/changes/anchor_item.dart';
import 'package:ytp_new/view/widget/fading_listview.dart';
import 'package:ytp_new/view/pages/playlist_page/tabs/changes/change_item.dart';

class ChangesTab extends StatefulWidget {
  final String playlistId;
  final ScrollController scrollController;
  const ChangesTab({
    super.key,
    required this.playlistId,
    required this.scrollController,
  });

  @override
  State<ChangesTab> createState() => _ChangesTabState();
}

class _ChangesTabState extends State<ChangesTab>
    with AutomaticKeepAliveClientMixin {
  Playlist get playlist => PlaylistStorageProvider().fromId(widget.playlistId)!;

  List<VideoChange> get changes => playlist.changes
    ..sort(
      (final fst, final snd) => fst.title.compareTo(snd.title),
    );

  List<Video> get anchorIssues => playlist.anchoredVideos
      .where((final video) => !video.anchorInPlace)
      .toList();

  @override
  Widget build(BuildContext context) {
    context.watch<AnchorStorageProvider>();

    super.build(context);
    return changes.isEmpty
        ? anchorIssues.isEmpty
            ? Center(
                child: Text(
                  playlist.state?.message ??
                      "Playlist has not been checked yet.",
                  style:
                      Theme.of(context).textTheme.labelLarge!.withOpacity(.5),
                ),
              )
            : FadingListView(
                controller: widget.scrollController,
                gradientHeight: 70,
                bottom: false,
                padding: const EdgeInsets.only(bottom: 80, top: 20),
                itemBuilder: (context, index) => AnchorItem(
                  playlistId: playlist.id,
                  video: anchorIssues[index],
                  isFirst: index == 0,
                  isLast: index == anchorIssues.length - 1,
                ),
                itemCount: anchorIssues.length,
              )
        : FadingListView(
            controller: widget.scrollController,
            gradientHeight: 70,
            bottom: false,
            padding: const EdgeInsets.only(bottom: 80, top: 20),
            itemBuilder: (context, index) => ChangeItem(
              change: changes[index],
              playlistId: playlist.id,
              isFirst: index == 0,
              isLast: index == changes.length - 1,
            ),
            itemCount: changes.length,
          );
  }

  @override
  bool get wantKeepAlive => mounted;
}

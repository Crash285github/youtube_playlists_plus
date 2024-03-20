import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/config.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/service/youtube_explode_service.dart';
import 'package:ytp_new/view/widget/media_item_template.dart';
import 'package:ytp_new/view/widget/thumbnail.dart';

class SearchResult extends StatefulWidget {
  final Playlist playlist;
  final bool isFirst, isLast;
  const SearchResult({
    super.key,
    required this.playlist,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  bool downloaded = false;

  BorderRadiusGeometry get borderRadius => BorderRadius.only(
        bottomLeft: Radius.circular(widget.isLast ? 16.0 : 4.0),
        bottomRight: Radius.circular(widget.isLast ? 16.0 : 4.0),
        topLeft: Radius.circular(widget.isFirst ? 16.0 : 4.0),
        topRight: Radius.circular(widget.isFirst ? 16.0 : 4.0),
      );

  BorderRadius get thumbnailBorderRadius => BorderRadius.only(
        bottomLeft: Radius.circular(widget.isLast ? 14.0 : 4.0),
        bottomRight: const Radius.circular(4.0),
        topLeft: Radius.circular(widget.isFirst ? 14.0 : 4.0),
        topRight: const Radius.circular(4.0),
      );

  @override
  Widget build(BuildContext context) {
    context.watch<PlaylistStorageProvider>();

    return AnimatedOpacity(
      duration: AppConfig.defaultAnimationDuration,
      opacity: downloaded ? .5 : 1,
      child: MediaItem(
        borderRadius: borderRadius,
        primaryAction: downloaded
            ? null
            : (_) async {
                setState(() => downloaded = true);
                Playlist? pl;
                try {
                  pl = await YoutubeService.download(widget.playlist);

                  PlaylistStorageProvider().add(pl);
                } catch (_) {
                  if (mounted) {
                    setState(() => downloaded =
                        PlaylistStorageProvider().playlists.contains(pl));
                  }
                }
              },
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            children: [
              Thumbnail(
                thumbnail: widget.playlist.thumbnail,
                height: 80,
                width: 80,
                borderRadius: thumbnailBorderRadius,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.playlist.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              if (PlaylistStorageProvider().playlists.contains(widget.playlist))
                const Icon(
                  Icons.download_done,
                  color: Colors.green,
                )
            ],
          ),
        ),
      ),
    );
  }
}

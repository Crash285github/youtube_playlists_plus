import 'package:flutter/material.dart';
import 'package:ytp_new/model/playlist.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/service/youtube_explode_service.dart';

class SearchResult extends StatelessWidget {
  final Playlist playlist;
  const SearchResult({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () async {
          final Playlist pl = await YoutubeExplodeService.download(playlist);
          PlaylistStorageProvider().add(pl);
        },
        child: Row(children: [
          Image.network(playlist.thumbnail),
          Text(playlist.title),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ytp_new/model/playlist.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/service/youtube_explode_service.dart';

class SearchResult extends StatefulWidget {
  final Playlist playlist;
  const SearchResult({super.key, required this.playlist});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  bool downloaded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: downloaded ? .5 : 1,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: downloaded
              ? null
              : () async {
                  setState(() => downloaded = true);
                  final Playlist pl =
                      await YoutubeExplodeService.download(widget.playlist);

                  PlaylistStorageProvider().add(pl);
                },
          child: Row(children: [
            Container(
              height: 80,
              width: 80,
              margin: const EdgeInsets.all(5.0),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                widget.playlist.thumbnail,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
                child: Text(
              widget.playlist.title,
              style: Theme.of(context).textTheme.titleLarge,
            )),
          ]),
        ),
      ),
    );
  }
}

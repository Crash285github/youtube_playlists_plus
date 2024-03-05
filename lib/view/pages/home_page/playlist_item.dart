import 'package:flutter/material.dart';
import 'package:ytp_new/model/playlist.dart';
import 'package:ytp_new/view/pages/playlist_page/playlist_page.dart';

class PlaylistItem extends StatelessWidget {
  final Playlist playlist;
  const PlaylistItem({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlaylistPage(playlist: playlist),
              ));
        },
        child: Row(
          children: [
            Image.network(playlist.thumbnail),
            Text(playlist.title),
          ],
        ),
      ),
    );
  }
}

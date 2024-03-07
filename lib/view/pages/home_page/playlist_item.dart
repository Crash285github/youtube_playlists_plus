import 'package:flutter/material.dart';
import 'package:ytp_new/model/playlist.dart';
import 'package:ytp_new/service/app_navigator.dart';
import 'package:ytp_new/view/pages/playlist_page/playlist_page.dart';
import 'package:ytp_new/view/thumbnail.dart';

class PlaylistItem extends StatelessWidget {
  final Playlist playlist;
  const PlaylistItem({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          AppNavigator.tryPopRight();
          AppNavigator.tryPushRight(PlaylistPage(playlist: playlist));
        },
        child: Row(
          children: [
            Thumbnail(
              thumbnail: playlist.thumbnail,
              height: 100,
              width: 100,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    playlist.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          playlist.author,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      const Icon(Icons.refresh)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

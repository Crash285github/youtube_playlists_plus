import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/model/playlist_storage.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/provider/settings_provider.dart';
import 'package:ytp_new/view/pages/home_page/playlist_item.dart';

class PlaylistListView extends StatefulWidget {
  const PlaylistListView({super.key});

  @override
  State<PlaylistListView> createState() => _PlaylistListViewState();
}

class _PlaylistListViewState extends State<PlaylistListView> {
  @override
  Widget build(BuildContext context) {
    final playlists = context.watch<PlaylistStorageProvider>().playlists;
    context.select<SettingsProvider, bool>(
      (final settings) => settings.canReorder,
    );

    return SliverReorderableList(
      proxyDecorator: (final child, final index, final animation) =>
          ScaleTransition(
        alignment: Alignment.centerRight,
        scale: animation.drive(Tween<double>(begin: 1, end: 1.1)),
        filterQuality: FilterQuality.none,
        child: Stack(
          children: [
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: index == playlists.length - 1
                      ? const Radius.circular(20.0)
                      : const Radius.circular(4.0),
                  bottomRight: index == playlists.length - 1
                      ? const Radius.circular(20.0)
                      : const Radius.circular(4.0),
                  topLeft: index == 0
                      ? const Radius.circular(20.0)
                      : const Radius.circular(4.0),
                  topRight: index == 0
                      ? const Radius.circular(20.0)
                      : const Radius.circular(4.0),
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: const SizedBox.expand(),
              ),
            ),
            Opacity(
              opacity: .6,
              child: child,
            ),
          ],
        ),
      ),
      itemCount: playlists.length,
      itemBuilder: (context, index) => ReorderableDragStartListener(
        index: index,
        enabled: SettingsProvider().canReorder,
        key: ValueKey(playlists[index]),
        child: PlaylistItem(
          playlist: playlists[index],
          isFirst: index == 0,
          isLast: index == playlists.length - 1,
        ),
      ),
      onReorder: (oldIndex, newIndex) {
        final copy = playlists.toList();
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }

        setState(() {
          final playlist = copy.removeAt(oldIndex);
          copy.insert(newIndex, playlist);
        });

        PlaylistStorage.replace(copy);
      },
    );
  }
}

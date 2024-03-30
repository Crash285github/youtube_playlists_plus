library home_page;

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ytp_new/config.dart';
import 'package:ytp_new/extensions/extensions.dart';
import 'package:ytp_new/model/persistence.dart';
import 'package:ytp_new/provider/fetching_provider.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/provider/settings_provider.dart';
import 'package:ytp_new/service/popup_service.dart';
import 'package:ytp_new/view/pages/home_page/drawer/preferences_drawer.dart';
import 'package:ytp_new/view/pages/playlist_page/playlist_page.dart';
import 'package:ytp_new/view/pages/search_page/search_page.dart';
import 'package:ytp_new/view/widget/app_navigator.dart';
import 'package:ytp_new/view/widget/media_item_template.dart';
import 'package:ytp_new/view/widget/thumbnail.dart';

part 'playlist_item.dart';
part 'playlist_list_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final canReorder = context.select<SettingsProvider, bool>(
        (final settings) => settings.canReorder);

    final hasPlaylists = context.select<PlaylistStorageProvider, bool>(
      (final playlistStorage) => playlistStorage.playlists.isNotEmpty,
    );

    final downloading = context.select<FetchingProvider, bool>(
      (final fetches) => fetches.downloading,
    );

    final refreshing = context.select<FetchingProvider, bool>(
      (final fetches) => fetches.refreshingList.isNotEmpty,
    );

    return Scaffold(
        drawer: PreferencesDrawer(),
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: const Text("Playlists"),
                  centerTitle: true,
                  floating: true,
                  snap: true,
                  actions: [
                    if (hasPlaylists)
                      IconButton(
                        onPressed: refreshing
                            ? null
                            : () async {
                                for (final playlist
                                    in PlaylistStorageProvider().playlists) {
                                  playlist.refresh();
                                }
                              },
                        icon: const Icon(Icons.refresh),
                        tooltip: "Refresh all",
                      ),
                  ],
                ),
                const _PlaylistListView(),
                const SliverToBoxAdapter(child: SizedBox(height: 40)),
                if (downloading)
                  const SliverToBoxAdapter(
                    child: Center(
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                const SliverToBoxAdapter(child: SizedBox(height: 40)),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: AnimatedSize(
            alignment: Alignment.centerRight,
            duration: AppConfig.defaultAnimationDuration,
            curve: Curves.decelerate,
            child: canReorder ? const Text("Finish") : const SizedBox.shrink(),
          ),
          extendedIconLabelSpacing: canReorder ? 8 : 0,
          extendedPadding: const EdgeInsets.all(16),
          tooltip: canReorder ? "Finish reordering" : "Search",
          onPressed: canReorder
              ? () => SettingsProvider().canReorder = false
              : () => AppNavigator.tryPushLeft(const SearchPage()),
          icon: Icon(canReorder ? Icons.done : Icons.search),
        ));
  }
}

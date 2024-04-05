library home_page;

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ytp_new/config.dart';
import 'package:ytp_new/extensions/extensions.dart';
import 'package:ytp_new/model/persistence.dart';
import 'package:ytp_new/provider/fetching_provider.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/provider/preferences_provider.dart';
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
    final canReorder = context.select<PreferencesProvider, bool>(
        (final preferences) => preferences.canReorder);

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
                hasPlaylists
                    ? const _PlaylistListView()
                    : SliverFillRemaining(
                        child: Center(
                          child: downloading
                              ? const Center(
                                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "You have no Playlists. To add some, "
                                    "search for them using the search button below.",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .withOpacity(.5),
                                  ),
                                ),
                        ),
                      ),
                if (hasPlaylists)
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
                if (hasPlaylists)
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
              ? () => PreferencesProvider().canReorder = false
              : () => AppNavigator.tryPushLeft(const SearchPage()),
          icon: Icon(canReorder ? Icons.done : Icons.search),
        ));
  }
}

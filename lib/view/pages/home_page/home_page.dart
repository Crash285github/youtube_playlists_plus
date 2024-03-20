import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytp_new/config.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/provider/refreshing_provider.dart';
import 'package:ytp_new/provider/settings_provider.dart';
import 'package:ytp_new/view/widget/app_navigator.dart';
import 'package:ytp_new/view/pages/home_page/drawer/drawer.dart';
import 'package:ytp_new/view/pages/home_page/playlist_list_view.dart';
import 'package:ytp_new/view/pages/search_page/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _scrollController;
  bool showFab = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset == 0 && !showFab) {
          setState(() => showFab = true);
        } else if (_scrollController.offset >= kToolbarHeight && showFab) {
          setState(() => showFab = false);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final canReorder = context.select<SettingsProvider, bool>(
        (final settings) => settings.canReorder);

    return Scaffold(
      drawer: const HomePageDrawer(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            title: const Text("Playlists"),
            centerTitle: true,
            floating: true,
            snap: true,
            actions: [
              IconButton(
                onPressed: RefreshingProvider().refreshingList.isEmpty
                    ? () async {
                        for (final playlist
                            in PlaylistStorageProvider().playlists) {
                          playlist.refresh();
                        }
                      }
                    : null,
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          const PlaylistListView(),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
      floatingActionButton: showFab || canReorder
          ? FloatingActionButton.extended(
              label: AnimatedSize(
                alignment: Alignment.centerRight,
                duration: AppConfig.defaultAnimationDuration,
                curve: Curves.decelerate,
                child:
                    canReorder ? const Text("Finish") : const SizedBox.shrink(),
              ),
              extendedIconLabelSpacing: canReorder ? 8 : 0,
              extendedPadding: const EdgeInsets.all(16),
              onPressed: canReorder
                  ? () => SettingsProvider().canReorder = false
                  : () => AppNavigator.tryPushLeft(const SearchPage()),
              icon: Icon(canReorder ? Icons.done : Icons.search),
            )
          : null,
    );
  }
}

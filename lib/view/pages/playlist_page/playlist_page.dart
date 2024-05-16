import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ytp_new/persistence/persistence.dart';
import 'package:ytp_new/provider/fetching_provider.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/service/popup_service.dart';
import 'package:ytp_new/view/pages/playlist_page/tabs/changes/changes_tab.dart';
import 'package:ytp_new/view/pages/playlist_page/tabs/history/history_tab.dart';
import 'package:ytp_new/view/pages/playlist_page/tabs/videos/planned_sheet/planned_item.dart';
import 'package:ytp_new/view/pages/playlist_page/tabs/videos/planned_sheet/planned_sheet_title.dart';
import 'package:ytp_new/view/pages/playlist_page/tabs/videos/videos_tab.dart';
import 'package:ytp_new/service/navigator_service.dart';
import 'package:ytp_new/view/widget/fading_listview.dart';

class PlaylistPage extends StatefulWidget {
  final String playlistId;
  const PlaylistPage({
    super.key,
    required this.playlistId,
  });

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  Playlist? get playlist => PlaylistStorageProvider().fromId(widget.playlistId);

  bool get refreshing =>
      FetchingProvider().isRefreshingPlaylist(widget.playlistId);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late final changesScrollController = ScrollController();
  late final videosScrollController = ScrollController();
  late final historyScrollController = ScrollController();

  ScrollController currentScrollController(int index) {
    switch (index) {
      case 0:
        return changesScrollController;
      case 1:
        return videosScrollController;
      case 2:
        return historyScrollController;
      default:
        throw Exception("Invalid index");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (playlist == null) return const SizedBox.shrink();

    context.watch<PlaylistStorageProvider>();
    context.watch<FetchingProvider>();

    return DefaultTabController(
      length: 3,
      initialIndex: playlist!.hasChanges ? 0 : 1,
      child: Builder(builder: (context) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: InkWell(
              onTap: () {
                final controller = currentScrollController(
                  DefaultTabController.of(context).index,
                );
                if (controller.hasClients && controller.offset > 0) {
                  controller.animateTo(
                    0,
                    duration: Duration(milliseconds: controller.offset ~/ 5),
                    curve: Curves.easeInOut,
                  );
                }
              },
              overlayColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.primary.withOpacity(.2),
              ),
              borderRadius: BorderRadius.circular(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(playlist!.title),
              ),
            ),
            centerTitle: true,
            automaticallyImplyLeading: !Preferences.isSplit,
            actions: [
              IconButton(
                onPressed: refreshing
                    ? null
                    : () async {
                        await playlist!.refresh();
                        Persistence.savePlaylists();
                      },
                icon: const Icon(Icons.refresh),
                tooltip: "Refresh",
              ),
              if (Platform.isWindows)
                IconButton(
                  onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
                  icon: const Icon(Icons.list_alt_outlined),
                  tooltip: "Planned",
                ),
              IconButton(
                onPressed: () {
                  if (Preferences.confirmDeletes) {
                    PopupService.confirmDialog(
                      context: context,
                      child: Text(
                        "'${playlist!.title}' will be deleted.",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ).then((value) {
                      if (value ?? false) {
                        NavigatorService.tryPopRight(context);
                        PlaylistStorageProvider().remove(playlist!);
                      }
                    });
                    return;
                  }

                  NavigatorService.tryPopRight(context);
                  PlaylistStorageProvider().remove(playlist!);
                },
                icon: Icon(
                  Icons.delete_outline,
                  color: Theme.of(context).colorScheme.error,
                ),
                tooltip: "Delete",
              ),
            ],
            backgroundColor: Colors.transparent,
            bottom: TabBar(
              tabAlignment: TabAlignment.center,
              splashBorderRadius: const BorderRadius.all(Radius.circular(12.0)),
              dividerHeight: 0,
              isScrollable: true,
              tabs: [
                _TabItem(
                  icon: Icon(
                    playlist!.state?.icon ?? Icons.change_circle,
                    color: playlist!.state?.color,
                  ),
                  text: "Changes",
                ),
                const _TabItem(
                  icon: Icon(Icons.list),
                  text: "Videos",
                ),
                const _TabItem(
                  icon: Icon(Icons.history),
                  text: "History",
                )
              ],
            ),
          ),
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              _BlurredThumbnail(url: playlist!.thumbnail),
              SafeArea(
                child: TabBarView(
                  children: [
                    ChangesTab(
                      playlistId: widget.playlistId,
                      scrollController: changesScrollController,
                    ),
                    VideosTab(
                      playlistId: widget.playlistId,
                      scrollController: videosScrollController,
                    ),
                    HistoryTab(
                      playlistId: widget.playlistId,
                      scrollController: historyScrollController,
                    ),
                  ],
                ),
              ),
            ],
          ),
          endDrawerEnableOpenDragGesture: false,
          endDrawer: Padding(
            padding: const EdgeInsets.only(
              top: kToolbarHeight,
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
            ),
            child: Drawer(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: Column(
                children: [
                  PlannedSheetTitle(playlistId: widget.playlistId),
                  Expanded(
                    child: FadingListView(
                      itemCount: playlist!.planned.length,
                      itemBuilder: (context, index) => PlannedItem(
                        playlistId: widget.playlistId,
                        text: playlist!
                            .planned[playlist!.planned.length - index - 1],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _BlurredThumbnail extends StatelessWidget {
  const _BlurredThumbnail({
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.topCenter,
        child: Stack(
          children: [
            ClipRect(
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.transparent],
                    ).createShader(
                        Rect.fromLTRB(0, 0, rect.width, rect.height));
                  },
                  blendMode: BlendMode.dstIn,
                  child: Opacity(
                    opacity: .7,
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: CachedNetworkImage(
                        imageUrl: url,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            const SizedBox.shrink(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class _TabItem extends StatelessWidget {
  final Icon icon;
  final String text;
  const _TabItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) => Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 10),
            Text(text),
          ],
        ),
      );
}

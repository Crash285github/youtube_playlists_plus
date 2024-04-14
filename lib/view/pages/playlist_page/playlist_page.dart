import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ytp_new/persistence/persistence.dart';
import 'package:ytp_new/provider/fetching_provider.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/service/popup_service.dart';
import 'package:ytp_new/view/pages/playlist_page/tabs/changes/tab_changes.dart';
import 'package:ytp_new/view/pages/playlist_page/tabs/history/tab_history.dart';
import 'package:ytp_new/view/pages/playlist_page/tabs/videos/planned_sheet/planned_item.dart';
import 'package:ytp_new/view/pages/playlist_page/tabs/videos/planned_sheet/planned_sheet_title.dart';
import 'package:ytp_new/view/pages/playlist_page/tabs/videos/tab_videos.dart';
import 'package:ytp_new/view/widget/app_navigator.dart';
import 'package:ytp_new/view/widget/fading_listview.dart';

class PlaylistPage extends StatelessWidget {
  final String playlistId;
  PlaylistPage({
    super.key,
    required this.playlistId,
  });

  Playlist? get playlist => PlaylistStorageProvider().fromId(playlistId);
  bool get refreshing => FetchingProvider().isRefreshingPlaylist(playlistId);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (playlist == null) return const SizedBox.shrink();

    context.watch<PlaylistStorageProvider>();
    context.watch<FetchingProvider>();

    return DefaultTabController(
      length: 3,
      initialIndex: playlist!.hasChanges ? 0 : 1,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(playlist!.title),
          centerTitle: true,
          automaticallyImplyLeading: !Preferences.isSplit,
          actions: [
            IconButton(
              onPressed: refreshing ? null : () => playlist!.refresh(),
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
                      AppNavigator.tryPopRight(context);
                      PlaylistStorageProvider().remove(playlist!);
                    }
                  });
                  return;
                }

                AppNavigator.tryPopRight(context);
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
              const _TabItem(icon: Icon(Icons.list), text: "Videos"),
              const _TabItem(icon: Icon(Icons.history), text: "History")
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
                  PlaylistPageTabChanges(playlistId: playlistId),
                  PlaylistPageTabVideos(playlistId: playlistId),
                  PlaylistPageTabHistory(playlistId: playlistId),
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
                PlannedSheetTitle(playlistId: playlistId),
                Expanded(
                  child: FadingListView(
                    itemCount: playlist!.planned.length,
                    itemBuilder: (context, index) => PlannedItem(
                      playlistId: playlistId,
                      text: playlist!
                          .planned[playlist!.planned.length - index - 1],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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

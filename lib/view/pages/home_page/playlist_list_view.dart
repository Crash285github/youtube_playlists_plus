part of home_page;

class _PlaylistListView extends StatefulWidget {
  const _PlaylistListView();

  @override
  State<_PlaylistListView> createState() => __PlaylistListViewState();
}

class __PlaylistListViewState extends State<_PlaylistListView> {
  List<Playlist> get playlists => PlaylistStorageProvider().playlists;

  @override
  Widget build(BuildContext context) {
    final length = context.select<PlaylistStorageProvider, int>(
      (value) => value.playlists.length,
    );
    context.select<PreferencesProvider, bool>(
      (final preferences) => preferences.canReorder,
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
                  bottomLeft: index == length - 1
                      ? const Radius.circular(20.0)
                      : const Radius.circular(4.0),
                  bottomRight: index == length - 1
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
                filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                child: const SizedBox.expand(),
              ),
            ),
            Opacity(
              opacity: .8,
              child: child,
            ),
          ],
        ),
      ),
      itemCount: length,
      itemBuilder: (context, index) => PlaylistItem(
        key: ValueKey(playlists[index]),
        playlist: playlists[index],
        isFirst: index == 0,
        isLast: index == length - 1,
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

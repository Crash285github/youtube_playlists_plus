library search_page;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart'
    show PlaylistId, SearchPlaylist, TypeFilters;

import 'package:ytp_new/config.dart';
import 'package:ytp_new/extensions/extensions.dart';
import 'package:ytp_new/model/persistence.dart';
import 'package:ytp_new/provider/fetching_provider.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/service/youtube_explode_service.dart';
import 'package:ytp_new/view/widget/media_item_template.dart';
import 'package:ytp_new/view/widget/thumbnail.dart';

part 'search_engine.dart';
part 'search_result.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<Playlist> results = [];
  final _node = FocusNode();
  late final TextEditingController _textEditingController;
  bool isSearching = false;
  bool hasSearched = false;

  String get message {
    if (!hasSearched) {
      return "You can search by plain text or by providing a URL.";
    }

    if (!isSearching && results.isEmpty) {
      return "Found nothing. \nMaybe the Playlists were already added?";
    }

    return "";
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _search(final String query) {
    hasSearched = true;
    setState(() => isSearching = true);

    SearchEngine.search(query).then(
      (value) {
        results
          ..clear()
          ..addAll(value);
        setState(() => isSearching = false);
      },
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              title: Row(
                children: [
                  Flexible(
                    child: TextField(
                      focusNode: _node,
                      enabled: !isSearching,
                      controller: _textEditingController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          label: const Text("Search playlists here..."),
                          suffixIcon: IconButton(
                              onPressed: () {
                                _textEditingController.clear();
                                _node.requestFocus();
                              },
                              icon: const Icon(Icons.clear))),
                      onSubmitted: (value) async => _search(value.trim()),
                    ),
                  ),
                  IconButton(
                    onPressed: isSearching
                        ? null
                        : () => _search(_textEditingController.text.trim()),
                    icon: const Icon(Icons.search),
                  )
                ],
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(4),
                child: isSearching
                    ? const LinearProgressIndicator()
                    : const SizedBox.shrink(),
              ),
            ),
            ...!isSearching && hasSearched && results.isNotEmpty
                ? [
                    SliverList.builder(
                      itemCount: results.length,
                      itemBuilder: (context, index) => SearchResult(
                        playlist: results[index],
                        isFirst: index == 0,
                        isLast: index == results.length - 1,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 80),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "Seems like we'we reached the end.\n"
                              "If you haven't found what you were looking for, "
                              "try a more specific query, "
                              "or pass the Playlist's link as a query.",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .withOpacity(.5),
                            ),
                          ),
                        ),
                      ),
                    )
                  ]
                : [
                    SliverFillRemaining(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            message,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .withOpacity(.5),
                          ),
                        ),
                      ),
                    )
                  ],
          ],
        ),
      );
}

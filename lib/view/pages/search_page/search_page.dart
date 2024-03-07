import 'package:flutter/material.dart';
import 'package:ytp_new/model/playlist.dart';
import 'package:ytp_new/view/pages/search_page/search_engine.dart';
import 'package:ytp_new/view/pages/search_page/search_result.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Playlist> results = [];
  final _node = FocusNode();
  late final TextEditingController _textEditingController;
  bool isSearching = false;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future _search(String query) async {
    setState(() => isSearching = true);

    results = await SearchEngine.searchPlaylists(query);

    setState(() => isSearching = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    onPressed: () =>
                        _search(_textEditingController.text.trim()),
                    icon: const Icon(Icons.search))
              ],
            ),
            bottom: isSearching
                ? const PreferredSize(
                    preferredSize: Size.fromHeight(4),
                    child: LinearProgressIndicator())
                : null,
          ),
          SliverList.list(
              children: [...results.map((e) => SearchResult(playlist: e))])
        ],
      ),
    );
  }
}

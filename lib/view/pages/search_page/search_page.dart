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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: TextField(
              onSubmitted: (value) async {
                results = await SearchEngine.searchPlaylists(value);
                setState(() {});
              },
            ),
          ),
          SliverList.list(
              children: [...results.map((e) => SearchResult(playlist: e))])
        ],
      ),
    );
  }
}

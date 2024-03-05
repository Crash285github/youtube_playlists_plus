import 'package:flutter/material.dart';
import 'package:ytp_new/model/playlist.dart';

class SearchResult extends StatelessWidget {
  final Playlist playlist;
  const SearchResult({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: Row(children: [
          Image.network(playlist.thumbnail),
          Text(playlist.title),
        ]),
      ),
    );
  }
}

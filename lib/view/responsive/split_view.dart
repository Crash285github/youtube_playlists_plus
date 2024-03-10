import 'package:flutter/material.dart';
import 'package:ytp_new/config.dart';
import 'package:ytp_new/model/playlist_storage.dart';
import 'package:ytp_new/view/pages/home_page/home_page.dart';
import 'package:ytp_new/view/responsive/empty_right.dart';

/// A left & right navigator layout
class SplitView extends StatelessWidget {
  const SplitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        if (PlaylistStorage.playlists.isNotEmpty)
          Expanded(
            child: Navigator(
                key: AppConfig.splitRightNavigatorKey,
                onGenerateRoute: (settings) => MaterialPageRoute(
                      builder: (context) => const EmptyRightSide(),
                    )),
          ),
        Expanded(
            child: Navigator(
          key: AppConfig.splitLeftNavigatorKey,
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        ))
      ],
    );
  }
}

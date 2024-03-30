import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ytp_new/model/theme_creator.dart';
import 'package:ytp_new/view/widget/app_navigator.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About")),
      body: ListView(
        children: [
          Text(
            "Hi there!",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Text("Here I'll explain a bit about the app and its features."),
          const Text("At first, you need to add a playlist to the app."),
          const Text(
              "You can do this by clicking the Search button on the bottom right."),
          const Text("You will be navigated to the Search page."),
          const Text(
              "There you can search for a playlist by its name, or by it's url"),
          const Text(
              "You can also somewhat filter the results by the author by typing '@authorname'"),
          const Text("After you find the playlist you want, click on it."),
          if (Platform.isAndroid)
            const Text(
                "Also, you can add Playlists by sharing them from Youtube."),
          const Text(
              "After you add a playlist, you can see it in the Home page."),
          const Text("Now you can manage the playlist's state."),
          const Text(
              "Any changes made to the Playlist on Youtube will be reflected here."),
          const Text("You can also add Anchors to the playlist's Videos."),
          const Text(
              "Anchors are positional markers that you can use to tell a Playlist to watch the video's position too."),
          const Text(
              "For example, you can add an Anchor to a Video as 'Middle + 4'."),
          const Text(
              "This will tell the Playlist to alert you the Video is not the 4th Video from the middle of the Playlist."),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AppNavigator.pushMain(
          Theme(
            data: ThemeCreator.theme.copyWith(
              appBarTheme: const AppBarTheme(
                surfaceTintColor: Colors.transparent,
              ),
              listTileTheme: const ListTileThemeData(
                visualDensity: VisualDensity.compact,
                dense: true,
              ),
            ),
            child: LicensePage(
              applicationName: "Youtube Playlists+",
              applicationVersion: "1.0.0",
              applicationIcon: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: const Image(
                  image: ResizeImage(
                    height: 40,
                    AssetImage("assets/app_icon.png"),
                  ),
                ),
              ),
            ),
          ),
        ),
        tooltip: "Licenses",
        child: const Icon(
          Icons.assignment,
        ),
      ),
    );
  }
}

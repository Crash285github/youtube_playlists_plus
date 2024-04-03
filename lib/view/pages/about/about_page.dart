library about_page;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ytp_new/extensions/extensions.dart';
import 'package:ytp_new/model/theme_creator.dart';
import 'package:ytp_new/view/widget/app_navigator.dart';

part 'section.dart';
part 'paragraph.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          children: [
            const _Section(
              paragraphs: [
                _Paragraph("Hi there!"),
                _Paragraph(
                  "Here I'll explain a bit about the app and its features.",
                ),
              ],
            ),
            const _Section(
              paragraphs: [
                _Paragraph(
                  "At first, you need to add a playlist to the app.",
                ),
                _Paragraph(
                  "You can do this by clicking the "
                  "Search button on the bottom right of the Home Page.",
                ),
              ],
            ),
            const _Section(
              paragraphs: [
                _Paragraph(
                  "You will be navigated to the Search page.",
                ),
                _Paragraph(
                  "There you can search for a playlist by "
                  "its name, or by it's url.",
                ),
              ],
            ),
            _Section(
              paragraphs: [
                const _Paragraph(
                  "You can also somewhat filter the results by the author by "
                  "typing '@authorname'",
                ),
                const _Paragraph(
                  "After you find the playlist you want, click on it. "
                  "This will download it locally.",
                ),
                if (Platform.isAndroid)
                  const _Paragraph(
                    "Also, you can add Playlists by sharing them from Youtube.",
                  ),
              ],
            ),
            const _Section(
              paragraphs: [
                _Paragraph(
                  "After you add a playlist, you can see it in the Home page.",
                ),
                _Paragraph("Now you can manage the Playlist's state."),
                _Paragraph(
                  "Any changes made to the Playlist on "
                  "Youtube will be reflected in the App.",
                ),
              ],
            ),
            const _Section(
              paragraphs: [
                _Paragraph(
                  "You can also add Anchors to any of the Playlist's Videos.",
                ),
                _Paragraph(
                  "Anchors are positional markers that you can use "
                  "to tell a Playlist to watch the video's position too.",
                ),
              ],
            ),
            const _Section(
              paragraphs: [
                _Paragraph(
                  "For example, you can add an Anchor to a Video as 'Middle + 4'.",
                ),
                _Paragraph(
                  "This will tell the Playlist to alert you that the Video is "
                  "not the 4th Video from the middle of the Playlist.",
                ),
              ],
            ),
            const _Section(
              paragraphs: [
                _Paragraph("UI Design reference:"),
                _Paragraph(
                  "https://m3.material.io/components",
                  link: true,
                ),
              ],
            ),
            const SizedBox(height: 80),
          ],
        ),
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
              applicationVersion: "1.0.2",
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

library about_page;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ytp_new/config.dart';
import 'package:ytp_new/extensions/extensions.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/persistence/persistence.dart';
import 'package:ytp_new/view/widget/app_navigator.dart';

part 'section.dart';
part 'paragraph.dart';
part 'example.dart';

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
              title: 'Hi there!',
              paragraphs: [
                _Paragraph(
                  "Here I'll try to explain how the "
                  "app works as well as possible.",
                ),
              ],
            ),
            const _Section(
              title: "Adding a Playlist",
              paragraphs: [
                _Paragraph(
                  "At first, you need to add a Playlist to the app.",
                ),
                _Paragraph(
                  "You can do this by clicking the "
                  "Search button on the Home Page.",
                ),
              ],
            ),
            _Example(
              paragraph: const _Paragraph("It looks like this:"),
              widget: Center(
                child: FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.search),
                ),
              ),
            ),
            const _Section(
              paragraphs: [
                _Paragraph(
                  "You will be navigated to the Search page.",
                ),
                _Paragraph(
                  "There you can search for a Playlist by "
                  "its name, or by it's url.",
                ),
              ],
            ),
            _Section(
              paragraphs: [
                const _Paragraph(
                  "Tip: You can also somewhat search by author if you "
                  "type '@authorname'.",
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
                  "After the searching finishes, you will (probably) see a "
                  "couple of Playlists. Just click whichever you want to add.",
                ),
              ],
            ),
            const _Section(
              title: "Managing a Playlist",
              paragraphs: [
                _Paragraph(
                  "After you add a Playlist, you can see it in the Home page.",
                ),
                _Paragraph(
                  "Any changes made to the Playlist on "
                  "Youtube will be reflected in the App.",
                ),
              ],
            ),
            const _Section(paragraphs: [
              _Paragraph(
                "There are two ways to refresh a Playlist; "
                "from the Playlist Page, or from the Home Page.",
              ),
              _Paragraph(
                "In both the refresh button is "
                "what you have to press.",
              )
            ]),
            _Example(
              paragraph: const _Paragraph("It looks like this:"),
              widget: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.refresh),
              ),
            ),
            const _Section(
              paragraphs: [
                _Paragraph(
                  "On the Home Page, this will refresh all "
                  "Playlists, while on the Playlist Page, only the given "
                  "Playlist will be refreshed.",
                )
              ],
            ),
            const _Section(
              paragraphs: [
                _Paragraph(
                  "During and after the refreshing, the Playlist's "
                  "status will update to one of 4: ",
                )
              ],
            ),
            _Example(
              paragraph: const _Paragraph("They are the following:"),
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...PlaylistState.values.map(
                    (final state) => Row(
                      children: [
                        Icon(
                          state.icon,
                          color: state.color,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Text(state.name),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const _Section(
              paragraphs: [
                _Paragraph(
                  "Checking means the Playlist is "
                  "currently being checked.",
                ),
                _Paragraph(
                  "\nUnchanged means the Playlist stayed the same as before.",
                ),
                _Paragraph(
                  "\nChanged means the opposite, a video has been added "
                  "or removed since the last check. Go to the Playlist Page's "
                  "'Changes' tab to see them.",
                ),
                _Paragraph(
                  "\nMissing means that the Playlist itself has "
                  "disappeared.",
                ),
              ],
            ),
            const _Section(
              title: "Anchors",
              paragraphs: [
                _Paragraph(
                  "You can also add Anchors to any of the Playlist's Videos.",
                ),
                _Paragraph(
                  "Anchors are position markers that you can use "
                  "to tell a Playlist to watch the video's position too.",
                ),
              ],
            ),
            _Section(
              paragraphs: [
                _Paragraph(
                  "To add an Anchor, "
                  "${Platform.isAndroid ? "hold" : "right-click"} on a Video.",
                ),
                const _Paragraph(
                  "This will bring up the Video's context menu, whre you will "
                  "find an option called 'Anchor'. Tapping it will bring up "
                  "a dialog window, where you can set the position and offset.",
                ),
              ],
            ),
            const _Section(
              paragraphs: [
                _Paragraph(
                  "There are 3 positions to choose from: "
                  "Start will calculate the anchor from the start of the "
                  "Playlist; Middle will do it from the middle, and End will "
                  "do it from the end.",
                ),
              ],
            ),
            const _Section(
              paragraphs: [
                _Paragraph(
                  "Offset is the 'offset' from the selected "
                  "position. 'Start' will basically make the offset an index. "
                  "'Middle' will allow offset values of half the length of "
                  "the Playlist, negative too. So Middle-5 means 5 places "
                  "before the Playlist's center. End only allows negative "
                  "values.",
                ),
              ],
            ),
            const _Section(
              title: "",
              paragraphs: [
                _Paragraph(
                  "And that is mostly it! "
                  "You can set your Preferences from the drawer from the "
                  "Home Screen, that's where you navigated to this Page :) "
                  "\n\nUI was inspired by Google's Material Design 3.",
                ),
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
              applicationVersion: AppConfig.appVersion,
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
        child: const Icon(Icons.assignment),
      ),
    );
  }
}

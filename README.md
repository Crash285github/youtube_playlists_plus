# Youtube Playlists Plus

Originally a quick project for a University class made in MAUI, I decided to redo and expand on it in Flutter.
(It's also gonna be much nicer looking and more efficient hopefully...)

> The general idea is to save some Playlists, and the application tells you when it changes, be it addition/removal.
I really needed something like this because when a video is deleted from Youtube (or privated), it is hidden from the Playlist too.
Without the App even if I notice there are less videos, I probably won't know what the deleted video was.
For this reason the app saves and compares a Playlist's older and recent states, and tells which videos are different, so you can act accordingly.

## So, what *will* the App be able to do?
- search Youtube Playlists with keywords ✔️
- save the selected Playlist's states and compare them later ✔️
- alert the user about any Playlist's changes ✔️
- store a Planned list for each Playlist ✔️
- keep a history of a Playlist's states ✔️
- lock video places in Playlists ✔️
- download videos ✔️


This App is made possible by the [youtube_explode_dart](https://pub.dev/packages/youtube_explode_dart) flutter package, which is a port from the C# [YoutubeExplode](https://github.com/Tyrrrz/YoutubeExplode/) library.

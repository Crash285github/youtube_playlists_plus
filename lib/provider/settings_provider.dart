import 'package:flutter/material.dart';
import 'package:ytp_new/model/local_storage.dart';
import 'package:ytp_new/model/playlist/playlist.dart';
import 'package:ytp_new/model/settings/settings.dart';
import 'package:ytp_new/model/settings/theme_creator.dart';
import 'package:ytp_new/provider/playlist_storage_provider.dart';
import 'package:ytp_new/service/app_data_service.dart';
import 'package:ytp_new/service/app_navigator.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeData get themeData =>
      theme == ThemeSetting.dark ? ThemeData.dark() : ThemeData.light();

  ThemeSetting get theme => Settings.theme;
  set theme(final ThemeSetting setting) {
    Settings.theme = setting;
    ThemeCreator.createColorScheme().then((value) => notifyListeners());
    Persistence.saveSettings();
  }

  SplitSetting get splitMode => Settings.splitMode;
  set splitMode(final SplitSetting setting) {
    Settings.splitMode = setting;
    notifyListeners();
    Persistence.saveSettings();
  }

  ColorSchemeSetting get colorScheme => Settings.colorScheme;
  set colorScheme(final ColorSchemeSetting colorScheme) {
    Settings.colorScheme = colorScheme;
    ThemeCreator.createColorScheme().then((value) => notifyListeners());

    Persistence.saveSettings();
  }

  bool get hideTopic => Settings.hideTopic;
  set hideTopic(final bool hideTopic) {
    Settings.hideTopic = hideTopic;
    notifyListeners();
  }

  bool get canReorder => Settings.canReorder;
  set canReorder(final bool canReorder) {
    Settings.canReorder = canReorder;
    notifyListeners();

    //? save changed order on finish
    if (!canReorder) {
      Persistence.savePlaylists();
    }
  }

  Future export() async => AppDataService.export();

  bool _managingAppData = false;
  bool get managingAppData => _managingAppData;
  set managingAppData(final bool value) {
    _managingAppData = value;
    notifyListeners();
  }

  Future import() async {
    managingAppData = true;
    final imported = await AppDataService.import();
    if (imported == null) {
      managingAppData = false;
      return;
    }

    AppNavigator.tryPopRight();

    theme = ThemeSetting.values[imported['appTheme']];
    colorScheme = ColorSchemeSetting.values[imported['appScheme']];
    splitMode = SplitSetting.values[imported['split']];

    final playlists = (imported['playlists'] as List)
        .map(
          (e) => Playlist.fromJson(e),
        )
        .toList();

    PlaylistStorageProvider().replace(playlists);
    managingAppData = false;
  }

  //_ Singleton
  static final _provider = SettingsProvider._();
  factory SettingsProvider() => _provider;
  SettingsProvider._();
}

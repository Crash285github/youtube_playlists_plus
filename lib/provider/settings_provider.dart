import 'package:flutter/material.dart';
import 'package:ytp_new/model/local_storage.dart';
import 'package:ytp_new/model/settings/settings.dart';
import 'package:ytp_new/model/settings/theme_creator.dart';

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

  bool get canReorder => Settings.canReorder;
  set canReorder(final bool canReorder) {
    Settings.canReorder = canReorder;
    notifyListeners();

    //? save changed order on finish
    if (!canReorder) {
      Persistence.savePlaylists();
    }
  }

  //_ Singleton
  static final _provider = SettingsProvider._();
  factory SettingsProvider() => _provider;
  SettingsProvider._();
}

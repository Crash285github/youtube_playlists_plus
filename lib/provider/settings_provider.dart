import 'package:flutter/material.dart';
import 'package:ytp_new/model/local_storage.dart';
import 'package:ytp_new/model/settings/settings.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeData get theme =>
      themeMode == ThemeSetting.dark ? ThemeData.dark() : ThemeData.light();
  ThemeSetting get themeMode => Settings.themeMode;
  set themeMode(final ThemeSetting setting) {
    Settings.themeMode = setting;
    notifyListeners();
    LocalStorage.saveSettings();
  }

  SplitSetting get splitMode => Settings.splitMode;
  set splitMode(final SplitSetting setting) {
    Settings.splitMode = setting;
    notifyListeners();
    LocalStorage.saveSettings();
  }

  //_ Singleton
  static final _provider = SettingsProvider._();
  factory SettingsProvider() => _provider;
  SettingsProvider._();
}

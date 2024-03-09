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
    ThemeCreator.create().then((value) => notifyListeners());
    LocalStorage.saveSettings();
  }

  SplitSetting get splitMode => Settings.splitMode;
  set splitMode(final SplitSetting setting) {
    Settings.splitMode = setting;
    notifyListeners();
    LocalStorage.saveSettings();
  }

  ColorSchemeSetting get colorScheme => Settings.colorScheme;
  set colorScheme(final ColorSchemeSetting colorScheme) {
    Settings.colorScheme = colorScheme;
    ThemeCreator.create().then((value) => notifyListeners());

    LocalStorage.saveSettings();
  }

  bool get canReorder => Settings.canReorder;
  set canReorder(bool canReorder) {
    Settings.canReorder = canReorder;
    notifyListeners();
  }

  //_ Singleton
  static final _provider = SettingsProvider._();
  factory SettingsProvider() => _provider;
  SettingsProvider._();
}

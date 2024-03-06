enum ThemeSetting { light, dark, amoled }

enum SplitSetting { disabled, even, uneven }

class Settings {
  static ThemeSetting themeMode = ThemeSetting.light;
  static SplitSetting splitMode = SplitSetting.disabled;
}

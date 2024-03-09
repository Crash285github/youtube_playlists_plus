import 'package:flutter/material.dart';

enum ThemeSetting { light, dark, amoled }

enum SplitSetting { disabled, even, uneven }

enum ColorSchemeSetting {
  dynamic(null),
  mono(Colors.grey),
  red(Colors.red),
  pink(Colors.pink),
  orange(Colors.orange),
  yellow(Colors.yellow),
  green(Colors.green),
  cyan(Colors.cyan),
  blue(Colors.blue),
  indigo(Colors.indigo),
  purple(Colors.purple),
  ;

  final Color? color;
  const ColorSchemeSetting(this.color);
}

class Settings {
  static ThemeSetting theme = ThemeSetting.light;
  static SplitSetting splitMode = SplitSetting.disabled;
  static ColorSchemeSetting colorScheme = ColorSchemeSetting.blue;
  static bool canReorder = false;
}

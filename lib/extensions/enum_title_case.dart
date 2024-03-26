part of extensions;

extension TitleCase on Enum {
  String get titleCase => switch (name.length) {
        0 => "",
        1 => name.toUpperCase(),
        _ => name[0].toUpperCase() + name.substring(1)
      };
}

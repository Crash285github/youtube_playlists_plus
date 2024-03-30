part of '../preferences_drawer.dart';

class _SelecteScheme extends StatelessWidget {
  const _SelecteScheme();

  Future _select(BuildContext context, Offset offset) async {
    final selectedScheme = await offset.showContextMenu<ColorSchemeSetting>(
      context: context,
      items: [
        ...ColorSchemeSetting.values.map(
          (final scheme) => PopupMenuItem(
            value: scheme,
            child: Text(scheme.titleCase),
          ),
        )
      ],
    );

    if (selectedScheme != null) {
      SettingsProvider().colorScheme = selectedScheme;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.select<SettingsProvider, String>(
      (final settings) => settings.colorScheme.titleCase,
    );

    return _SettingTemplate(
      onTapUp: (details) => _select(context, details.globalPosition),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Icon(Icons.color_lens_outlined),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text("Color scheme"),
              ),
            ],
          ),
          Text(scheme),
        ],
      ),
    );
  }
}

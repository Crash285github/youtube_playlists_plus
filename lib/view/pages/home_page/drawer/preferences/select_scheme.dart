part of preferences_drawer;

class _SelecteScheme extends StatelessWidget {
  const _SelecteScheme();

  Future _select(BuildContext context, Offset offset) async {
    final selectedScheme = await offset.showContextMenu<ColorSchemePreference>(
      context: context,
      items: [
        ...ColorSchemePreference.values.map(
          (final scheme) => PopupMenuItem(
            value: scheme,
            child: Text(scheme.toTitleCase()),
          ),
        )
      ],
    );

    if (selectedScheme != null) {
      PreferencesProvider().colorScheme = selectedScheme;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.select<PreferencesProvider, String>(
      (final settings) => settings.colorScheme.toTitleCase(),
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

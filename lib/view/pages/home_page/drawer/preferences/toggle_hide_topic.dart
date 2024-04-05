part of preferences_drawer;

class _ToggleHideTopic extends StatelessWidget {
  const _ToggleHideTopic();

  bool get _enabled => Preferences.hideTopic;

  void _toggle() => PreferencesProvider().hideTopic = !Preferences.hideTopic;

  @override
  Widget build(BuildContext context) {
    context.select<PreferencesProvider, bool>(
      (final settings) => settings.hideTopic,
    );

    return _SettingTemplate(
      onTap: _toggle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Icon(Icons.note_outlined),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text("Hide '- Topic'"),
              )
            ],
          ),
          Switch(
            value: _enabled,
            onChanged: (_) => _toggle(),
          )
        ],
      ),
    );
  }
}

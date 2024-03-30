part of '../preferences_drawer.dart';

class _ToggleHideTopic extends StatelessWidget {
  const _ToggleHideTopic();

  bool get _enabled => Settings.hideTopic;

  void _toggle() => SettingsProvider().hideTopic = !Settings.hideTopic;

  @override
  Widget build(BuildContext context) {
    context.select<SettingsProvider, bool>(
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

part of '../preferences_drawer.dart';

class _ToggleConfirmDelete extends StatelessWidget {
  const _ToggleConfirmDelete();

  bool get _enabled => Settings.confirmDeletes;

  void _toggle() =>
      SettingsProvider().confirmDeletes = !Settings.confirmDeletes;

  @override
  Widget build(BuildContext context) {
    context.select<SettingsProvider, bool>(
      (final settings) => settings.confirmDeletes,
    );

    return _SettingTemplate(
      onTap: _toggle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Icon(Icons.delete_outline),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text("Confirm deletions"),
              )
            ],
          ),
          Switch(
            value: _enabled,
            onChanged: (_) => _toggle(),
          ),
        ],
      ),
    );
  }
}

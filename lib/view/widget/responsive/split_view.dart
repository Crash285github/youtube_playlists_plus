part of responsive;

/// A left & right navigator layout
class _SplitView extends StatelessWidget {
  const _SplitView();

  @override
  Widget build(BuildContext context) {
    final isEven = context.select<PreferencesProvider, bool>(
      (final preferences) => preferences.splitMode == SplitPreference.even,
    );

    return Row(
      children: [
        Expanded(
          flex: isEven ? 1 : 3,
          child: Navigator(
            key: AppConfig.splitLeftNavigatorKey,
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          ),
        ),
        Expanded(
          flex: isEven ? 1 : 5,
          child: Navigator(
            key: AppConfig.splitRightNavigatorKey,
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => const _EmptyRightSide(),
            ),
          ),
        )
      ],
    );
  }
}

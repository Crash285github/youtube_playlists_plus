part of responsive;

/// The bottom of the right navigator's stack
class _EmptyRightSide extends StatelessWidget {
  const _EmptyRightSide();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Select a playlist"),
      ),
    );
  }
}

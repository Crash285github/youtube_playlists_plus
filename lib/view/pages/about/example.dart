part of about_page;

class _Example extends StatelessWidget {
  final _Paragraph paragraph;
  final Widget widget;
  const _Example({required this.paragraph, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(child: paragraph),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: widget,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

part of about_page;

class _Section extends StatelessWidget {
  final List<_Paragraph> paragraphs;
  final String? title;
  const _Section({required this.paragraphs, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: title != null ? 32.0 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                title!,
                style:
                    Theme.of(context).textTheme.headlineMedium!.withOpacity(.5),
              ),
            ),
          Center(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: paragraphs),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

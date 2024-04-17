part of about_page;

class _Paragraph extends StatelessWidget {
  final String text;
  final bool link;
  const _Paragraph(this.text, {this.link = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !link ? null : () => launchUrl(Uri.parse(text)),
      child: Text(
        text,
        textAlign: TextAlign.justify,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(decoration: link ? TextDecoration.underline : null)
            .withOpacity(.5),
      ),
    );
  }
}

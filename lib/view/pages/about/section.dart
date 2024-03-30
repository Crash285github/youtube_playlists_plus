part of 'about_page.dart';

class _Section extends StatelessWidget {
  final List<_Paragraph> paragraphs;
  const _Section({required this.paragraphs});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Column(children: paragraphs),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ytp_new/view/pages/home_page/home_page.dart';
import 'package:ytp_new/view/responsive/split_view.dart';

class Responsive extends StatelessWidget {
  const Responsive({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 700) {
          return const SplitView();
        } else {
          return const HomePage();
        }
      },
    );
  }
}

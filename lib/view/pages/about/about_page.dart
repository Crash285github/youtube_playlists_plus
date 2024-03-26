import 'package:flutter/material.dart';
import 'package:ytp_new/view/widget/app_navigator.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AppNavigator.pushMain(const LicensePage()),
        tooltip: "Licenses",
        child: const Icon(
          Icons.assignment,
        ),
      ),
    );
  }
}

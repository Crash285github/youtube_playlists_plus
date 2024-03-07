import 'package:flutter/material.dart';

class EmptyRightSide extends StatelessWidget {
  const EmptyRightSide({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Select a playlist"),
      ),
    );
  }
}

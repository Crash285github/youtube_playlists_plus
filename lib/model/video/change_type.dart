import 'package:flutter/material.dart';

enum VideoChangeType {
  addition(Colors.green, Icons.add_circle_outline),
  removal(Colors.red, Icons.remove_circle_outline),
  ;

  final Color color;
  final IconData icon;

  const VideoChangeType(this.color, this.icon);
}

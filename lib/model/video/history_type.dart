import 'package:flutter/material.dart';

enum VideoHistoryType {
  addition(Colors.green, Icon(Icons.add_circle_outline)),
  removal(Colors.red, Icon(Icons.remove_circle_outline)),
  ;

  final Color color;
  final Icon icon;

  const VideoHistoryType(this.color, this.icon);
}

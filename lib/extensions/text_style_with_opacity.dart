import 'package:flutter/material.dart';

extension WithOpacity on TextStyle {
  /// Sets an opacity to the style
  TextStyle withOpacity(double value) {
    assert(value >= 0.0 && value <= 1.0);
    return copyWith(color: color?.withOpacity(value));
  }
}

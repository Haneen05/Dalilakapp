import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  bool operator <(TimeOfDay other) {
    return inMinutes < other.inMinutes;
  }

  bool operator >(TimeOfDay other) {
    return inMinutes > other.inMinutes;
  }

  int get inMinutes {
    return hour * 60 + minute;
  }
}

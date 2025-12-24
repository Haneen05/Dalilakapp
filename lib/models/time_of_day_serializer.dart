import 'package:daleelakappx/extensions/time_of_day.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class TimeOfDaySerializer implements JsonConverter<TimeOfDay, int> {
  const TimeOfDaySerializer();

  @override
  TimeOfDay fromJson(int timeOfDay) => TimeOfDay(
        hour: timeOfDay ~/ 60,
        minute: timeOfDay % 60,
      );

  @override
  int toJson(TimeOfDay timeOfDay) => timeOfDay.inMinutes;
}

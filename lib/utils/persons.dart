import 'package:flutter/material.dart';

class Persons implements Comparable<Persons>{
  String medicina, timer;
  Persons(this.medicina, this.timer);

  @override
  int compareTo(Persons other) {
    TimeOfDay thisTime = TimeOfDay(
      hour: int.parse(timer.split(":")[0]),
      minute: int.parse(timer.split(":")[1])
    );
    TimeOfDay otherTime = TimeOfDay(
      hour: int.parse(other.timer.split(":")[0]),
      minute: int.parse(other.timer.split(":")[1])
    );
    if (thisTime.hour != otherTime.hour) {
      return thisTime.hour - otherTime.hour;
    } else {
      return thisTime.minute - otherTime.minute;
    }
  }
}

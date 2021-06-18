import 'package:flutter/material.dart';
import 'package:kowoerka/model/user.dart';

class Reservation {
  int workspaceID;
  User user;
  DateTime date;
  TimeOfDay startTime;
  TimeOfDay endTime;
  double pricePerHour;

  Reservation(
      {required this.workspaceID,
      required this.user,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.pricePerHour});
}

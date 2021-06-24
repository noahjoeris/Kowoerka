import 'package:flutter/material.dart';
import 'package:kowoerka/model/user.dart';
import 'package:kowoerka/model/workspace.dart';

class Reservation {
  String id;
  Workspace workspace;
  User user;
  DateTime dateTimeStart;
  DateTime dateTimeEnd;
  double pricePerHour;

  double getOverallPrice() {
    return dateTimeEnd.difference(dateTimeStart).inHours * pricePerHour;
  }

  Reservation(
      {required this.id,
      required this.workspace,
      required this.user,
      required this.dateTimeStart,
      required this.dateTimeEnd,
      required this.pricePerHour});
}

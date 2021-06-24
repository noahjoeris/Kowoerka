import 'package:flutter/material.dart';
import 'package:kowoerka/components/reservation_list.dart';
import 'package:kowoerka/model/reservation.dart';
import 'package:kowoerka/model/reservation_repository.dart';
import 'package:kowoerka/model/user.dart';
import 'package:kowoerka/services/locator.dart';

class ReservationsScreen extends StatelessWidget {
  List<Reservation> _reservations;

  ReservationsScreen(this._reservations);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Workspace Reservations"),
      ),
      body: _reservations.isNotEmpty
          ? ReservationList(_reservations)
          : Center(child: Text("You never booked a workspace yet")),
    );
  }
}

import "package:flutter/material.dart";
import 'package:kowoerka/components/search_app_bar.dart';
import 'package:kowoerka/model/reservation.dart';
import 'package:kowoerka/model/user.dart';

class ReservationList extends StatefulWidget {
  @override
  _ReservationListState createState() => _ReservationListState();

  List<Reservation> _reservations;
  User? _loggedInUser;

  ReservationList(this._reservations, [this._loggedInUser]);
}

class _ReservationListState extends State<ReservationList> {
  @override
  Widget build(BuildContext context) {
    List<Reservation> reservationsSortedByTime = widget._reservations
      ..sort((r1, r2) => r1.dateTimeStart.compareTo(r2.dateTimeStart));
    return ListView.builder(
      itemCount: reservationsSortedByTime.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () {},
        title: Column(
          children: [
            Text(
                "${reservationsSortedByTime[index].dateTimeStart.day}.${reservationsSortedByTime[index].dateTimeStart.month}.${reservationsSortedByTime[index].dateTimeStart.year} - ${reservationsSortedByTime[index].dateTimeEnd.day}.${reservationsSortedByTime[index].dateTimeEnd.month}.${reservationsSortedByTime[index].dateTimeEnd.year}"),
            Text(
              "${TimeOfDay.fromDateTime(reservationsSortedByTime[index].dateTimeStart).format(context)} - ${TimeOfDay.fromDateTime(reservationsSortedByTime[index].dateTimeEnd).format(context)}",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        leading: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(
                "assets/images/workspace${reservationsSortedByTime[index].workspace.imageNumber}.jpg")),
      ),
    );
  }
}

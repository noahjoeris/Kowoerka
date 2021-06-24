import "package:flutter/material.dart";
import 'package:kowoerka/model/location_repository.dart';
import 'package:kowoerka/model/reservation.dart';
import 'package:kowoerka/model/user.dart';
import 'package:kowoerka/services/locator.dart';

class ReservationList extends StatefulWidget {
  @override
  _ReservationListState createState() => _ReservationListState();

  List<Reservation> _reservations;
  User? _loggedInUser;

  //loggedInUser can be later used to be able to edit certain Reservations that belongs to user
  ReservationList(this._reservations, [this._loggedInUser]);
}

class _ReservationListState extends State<ReservationList> {
  @override
  Widget build(BuildContext context) {
    List<Reservation> reservationsSortedByTime = widget._reservations
      ..sort((r1, r2) => r1.dateTimeStart.compareTo(r2.dateTimeStart));
    return widget._reservations.isEmpty
        ? Center(
            child: Text("No Reservations"),
          )
        : ListView.builder(
            itemCount: reservationsSortedByTime.length,
            itemBuilder: (context, index) => ListTile(
              title: Column(
                children: [
                  Text(
                    locator<LocationRepository>().getAddressForWorkspace(
                        reservationsSortedByTime[index].workspace),
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    "${reservationsSortedByTime[index].dateTimeStart.day}.${reservationsSortedByTime[index].dateTimeStart.month}.${reservationsSortedByTime[index].dateTimeStart.year} - ${reservationsSortedByTime[index].dateTimeEnd.day}.${reservationsSortedByTime[index].dateTimeEnd.month}.${reservationsSortedByTime[index].dateTimeEnd.year}",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "${TimeOfDay.fromDateTime(reservationsSortedByTime[index].dateTimeStart).format(context)} - ${TimeOfDay.fromDateTime(reservationsSortedByTime[index].dateTimeEnd).format(context)}",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              leading: CircleAvatar(
                  radius: 22,
                  backgroundImage: AssetImage(
                      "assets/images/workspace${reservationsSortedByTime[index].workspace.imageNumber}.jpg")),
            ),
          );
  }
}

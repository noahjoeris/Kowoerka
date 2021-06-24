import 'package:flutter/material.dart';
import 'package:kowoerka/model/reservation.dart';
import 'package:kowoerka/model/user.dart';
import 'package:kowoerka/model/workspace.dart';

class ReservationRepository {
  List<Reservation> _reservations;

  List<Reservation> get reservations => _reservations;

  ReservationRepository(this._reservations);

  ///return: the upcoming reservations
  List<Reservation> getUpcomingWorkspaceReservations(Workspace workspace) {
    return _reservations
        .where((element) =>
            element.workspace.id == workspace.id &&
            element.dateTimeStart.isAfter(DateTime.now()))
        .toList();
  }

  /// return: null if not booked or reservation if booked
  Reservation? getCurrentWorkspaceReservation(Workspace workspace) {
    for (int i = 0; i < _reservations.length; i++) {
      if (_reservations[i].workspace.id == workspace.id) {
        if (_reservations[i].dateTimeStart.compareTo(DateTime.now()) <= 0 &&
            _reservations[i].dateTimeEnd.compareTo(DateTime.now()) >= 0)
          return _reservations[i];
      }
    }
    return null;
  }

  List<Reservation> getReservationsForUser(User u) {
    return _reservations.where((element) => element.user.id == u.id).toList();
  }

  //check for collisions
  bool isAvailable(Reservation r) {
    return _reservations.every((repoElement) {
      if (r.workspace.id == repoElement.workspace.id) {
        if ((repoElement.dateTimeStart.isAfter(r.dateTimeStart) &&
                repoElement.dateTimeStart.isAfter(r.dateTimeEnd)) ||
            (repoElement.dateTimeStart.isBefore(r.dateTimeStart) &&
                repoElement.dateTimeStart.isBefore(r.dateTimeEnd))) return true;
        return false;
      }
      return true;
    });
  }

  void removeReservation(Reservation r) {
    _reservations.remove(r);
  }
}

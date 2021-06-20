import 'package:kowoerka/model/reservation.dart';

class ReservationRepository {
  List<Reservation> _reservations;

  List<Reservation> get reservations => _reservations;

  ReservationRepository(this._reservations);

  ///return: the upcoming reservations
  List<Reservation> getUpcomingWorkspaceReservations(String workspaceID) {
    return _reservations
        .where((element) => element.dateTimeStart.isAfter(DateTime.now()))
        .toList();
  }

  /// return: null if not booked or reservation if booked
  Reservation? getCurrentWorkspaceReservation(String workspaceID) {
    for (int i = 0; i < _reservations.length; i++) {
      if (_reservations[i].workspaceID == workspaceID &&
          _reservations[i].dateTimeStart.isBefore(DateTime.now()) &&
          _reservations[i].dateTimeEnd.isAfter(DateTime.now())) {
        return _reservations[i];
      }
    }
    return null;
  }
}

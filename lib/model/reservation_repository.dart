import 'package:kowoerka/model/reservation.dart';

class ReservationRepository {
  List<Reservation> _reservations;

  List<Reservation> get reservations => _reservations;

  ReservationRepository(this._reservations);
}

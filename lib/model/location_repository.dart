import 'package:kowoerka/model/location.dart';

class LocationRepository {
  List<Location> _locations;

  List<Location> get locations => _locations;

  LocationRepository(this._locations);
}

import 'package:kowoerka/model/location.dart';
import 'package:kowoerka/model/user.dart';
import 'package:kowoerka/model/workspace.dart';

class LocationRepository {
  List<Location> _locations;

  List<Location> get locations => _locations;

  LocationRepository(this._locations);

  // TODO: refactoring needed! - workspace should know its location and address
  String getAddressForWorkspace(Workspace workspace) {
    Location l = _locations
        .firstWhere((element) => element.workspaces.contains(workspace));

    return "${l.street} ${l.houseNumber}, ${l.city}";
  }

  List<Location> getLocationsByUser(User user) {
    return _locations
        .where((element) => element.realEstateAgent.id == user.id)
        .toList();
  }
}

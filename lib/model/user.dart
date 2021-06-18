import 'package:kowoerka/model/location.dart';
import 'package:kowoerka/model/workspace.dart';

class User {
  String name;
  List<Location> favouriteLocations;
  List<Workspace> favouriteWorkspaces;

  User(
      {required this.name,
      required this.favouriteLocations,
      required this.favouriteWorkspaces});
}

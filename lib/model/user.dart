import 'package:kowoerka/model/location.dart';
import 'package:kowoerka/model/workspace.dart';

class User {
  int id;
  String name;
  List<Location> favouriteLocations;
  List<Workspace> favouriteWorkspaces;
  String mobilephoneNumber;

  User(
      {required this.id,
      required this.name,
      required this.favouriteLocations,
      required this.favouriteWorkspaces,
      required this.mobilephoneNumber});
}

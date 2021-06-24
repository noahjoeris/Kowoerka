import 'package:kowoerka/model/user.dart';
import 'package:kowoerka/model/workspace.dart';

class Location {
  String id;
  String street;
  String houseNumber;
  String postalCode;
  String city;
  User realEstateAgent;
  String description;
  List<String> features;
  int imageNumber;

  List<Workspace> workspaces;

  Location(
      {required this.id,
      required this.street,
      required this.houseNumber,
      required this.postalCode,
      required this.city,
      required this.realEstateAgent,
      required this.description,
      required this.features,
      required this.imageNumber,
      required this.workspaces});
}

import 'package:kowoerka/model/location.dart';

class Workspace {
  String id;
  String description;
  List<String> features;
  double pricePerHour;
  int imageNumber;

  Workspace(
      {required this.id,
      required this.description,
      required this.features,
      required this.pricePerHour,
      required this.imageNumber});
}

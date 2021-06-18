import 'package:kowoerka/model/real_estate_agent.dart';

class Location {
  int id;
  String street;
  String houseNumber;
  int postalCode;
  String city;
  RealEstateAgent realEstateAgent;
  String description;
  List<String> features;
  int popularityScrore;
  //maybe safe isFavorited too? -> would force single user usage but safe a lot of work

  Location({
    required this.id,
    required this.street,
    required this.houseNumber,
    required this.postalCode,
    required this.city,
    required this.realEstateAgent,
    required this.description,
    required this.features,
    required this.popularityScrore,
  });
}

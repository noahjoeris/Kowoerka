import 'dart:math';

import 'package:kowoerka/model/location.dart';
import 'package:faker/faker.dart';
import 'package:kowoerka/model/user.dart';
import 'package:kowoerka/model/workspace.dart';

List<Location> generateFakeLocationsWithWorkspaces(
    {int size = 100, required List<User> agents}) {
  List<Location> locations = List.empty(growable: true);

  for (int i = 0; i < size; i++) {
    locations.add(Location(
      id: faker.guid.guid(),
      city: faker.address.city(),
      postalCode: faker.address.zipCode(),
      street: faker.address.streetSuffix(),
      houseNumber: (Random().nextInt(200) + 1).toString(),
      popularityScrore: Random().nextInt(100),
      description:
          "This building suits perfectly to entrepreneurs and freelancers",
      realEstateAgent: agents[Random().nextInt(agents.length)],
      features: ["Parking", "Pool", "Awesome View", "Coffee", "Silent"],
      imageNumber: Random().nextInt(4) + 1,
      workspaces: generateFakeWorkspaces(),
    ));
  }
  return locations;
}

List<User> generateFakeUsers({int size = 10}) {
  List<User> users = List.empty(growable: true);

  for (int i = 0; i < size; i++) {
    users.add(User(
        id: i,
        mobilephoneNumber: faker.phoneNumber.us(),
        name: faker.person.name(),
        favouriteLocations: List<Location>.empty(),
        favouriteWorkspaces: List<Workspace>.empty()));
  }
  return users;
}

List<Workspace> generateFakeWorkspaces({int maxSizePerLocation = 30}) {
  int realSize = Random().nextInt(maxSizePerLocation) + 5;
  List<Workspace> workspaces = List.empty(growable: true);

  for (int i = 0; i < realSize; i++) {
    workspaces.add(Workspace(
        id: faker.guid.guid(),
        description:
            "This workspace has everything you need to work as productively as possible.",
        features: List.of(
            ["Height adjustable desk", "Monitor(4k)", "Power supply", "Lamp"]),
        pricePerHour: ((Random().nextDouble() * 100)).roundToDouble() / 10 + 1,
        imageNumber: Random().nextInt(5) + 1));
  }
  return workspaces;
}

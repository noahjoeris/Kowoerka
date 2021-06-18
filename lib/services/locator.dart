import 'dart:math';

import 'package:faker/faker.dart';
import 'package:get_it/get_it.dart';
import 'package:kowoerka/model/location.dart';
import 'package:kowoerka/model/location_repository.dart';
import 'package:kowoerka/model/reservation.dart';
import 'package:kowoerka/model/reservation_repository.dart';
import 'package:kowoerka/model/user.dart';
import 'package:kowoerka/model/user_repository.dart';
import 'package:kowoerka/model/workspace.dart';
import 'package:kowoerka/services/fake_data_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  List<User> users = generateFakeUsers();
  locator.registerLazySingleton<UserRepository>(() => UserRepository(users));
  locator.registerLazySingleton<LocationRepository>(() =>
      LocationRepository(generateFakeLocationsWithWorkspaces(agents: users)));
  locator.registerLazySingleton<ReservationRepository>(
      () => ReservationRepository(List<Reservation>.empty(growable: true)));
}

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flip_card/flip_card.dart';
import 'package:kowoerka/components/favourite_button.dart';
import 'package:kowoerka/model/location.dart';
import 'package:kowoerka/model/user_repository.dart';
import 'package:kowoerka/screens/workspace_selector_screen.dart';
import 'package:kowoerka/services/locator.dart';

class LocationListItem extends StatelessWidget {
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  final Location _location;
  final bool _agentViewActive;

  LocationListItem(this._location, [this._agentViewActive = false]);

  @override
  Widget build(BuildContext context) {
    return FlipCard(
        key: cardKey,
        direction: FlipDirection.HORIZONTAL,
        flipOnTouch: false,
        front: FlipCardFront(
          cardKey: cardKey,
          location: _location,
          agentViewActive: _agentViewActive,
        ),
        back: FlipCardBack(
          cardKey: cardKey,
          location: _location,
        ));
  }
}

class FlipCardFront extends StatelessWidget {
  const FlipCardFront({
    Key? key,
    required this.cardKey,
    required this.location,
    required this.agentViewActive,
  }) : super(key: key);

  final GlobalKey<FlipCardState> cardKey;
  final Location location;
  final bool agentViewActive;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      WorkspaceSelectorScreen(location.workspaces)));
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Positioned.fill(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: agentViewActive
                      ? IconButton(
                          onPressed: () {},
                          splashColor: Colors.blue.shade100,
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                            size: 30,
                          ))
                      : FavouriteButton(
                          active: locator<UserRepository>()
                              .getLoggedInUser()
                              .favouriteLocations
                              .any((element) => element.id == location.id),
                          onActivated: () {
                            locator<UserRepository>()
                                .getLoggedInUser()
                                .favouriteLocations
                                .add(location);
                          },
                          onInactivated: () {
                            locator<UserRepository>()
                                .getLoggedInUser()
                                .favouriteLocations
                                .remove(location);
                          },
                        ),
                ),
              )),
              Ink.image(
                height: 190,
                fit: BoxFit.fitWidth,
                image: AssetImage(
                    "assets/images/location${location.imageNumber}.jpg"),
              ),
            ]),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "${location.street} ${location.houseNumber}, ${location.postalCode} ${location.city}"),
                      Text("${location.workspaces.length} seats")
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        cardKey.currentState?.toggleCard();
                      },
                      child: Text("Details"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FlipCardBack extends StatelessWidget {
  const FlipCardBack({Key? key, required this.cardKey, required this.location})
      : super(key: key);

  final GlobalKey<FlipCardState> cardKey;
  final Location location;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          cardKey.currentState?.toggleCard();
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                      "${location.description}.\n\nFeatures: ${location.features.toString()}\n\nContact: ${location.realEstateAgent.name}, ${location.realEstateAgent.mobilephoneNumber}"),
                ),
                SizedBox(
                  height: 70,
                ),
                Divider(
                  indent: 10,
                  endIndent: 10,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${location.street} ${location.houseNumber}, ${location.postalCode} ${location.city}",
                  ),
                  Text("${location.workspaces.length} seats")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

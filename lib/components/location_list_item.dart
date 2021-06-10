import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flip_card/flip_card.dart';

class LocationListItem extends StatelessWidget {
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  final int overallSpaces = Random().nextInt(30) + 30;
  final int leftSpaces = Random().nextInt(30);
  final int streetNumber = Random().nextInt(100);

  @override
  Widget build(BuildContext context) {
    return FlipCard(
        key: cardKey,
        direction: FlipDirection.HORIZONTAL,
        flipOnTouch: false,
        front: FlipCardFront(
          cardKey: cardKey,
          overallSpaces: overallSpaces,
          leftSpaces: leftSpaces,
          streetNumber: streetNumber,
        ),
        back: FlipCardBack(
          cardKey: cardKey,
          overallSpaces: overallSpaces,
          leftSpaces: leftSpaces,
          streetNumber: streetNumber,
        ));
  }
}

class FlipCardFront extends StatelessWidget {
  const FlipCardFront(
      {Key? key,
      required this.cardKey,
      required this.overallSpaces,
      required this.leftSpaces,
      required this.streetNumber})
      : super(key: key);

  final GlobalKey<FlipCardState> cardKey;
  final int overallSpaces;
  final int leftSpaces;
  final int streetNumber;
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              FavouriteButton(),
              Ink.image(
                height: 150,
                fit: BoxFit.fitWidth,
                image: AssetImage(
                    "assets/images/location${Random().nextInt(4) + 1}.jpg"),
              ),
            ]),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Street $streetNumber, 64293 Darmstadt"),
                      Text("$leftSpaces/$overallSpaces left")
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
  const FlipCardBack(
      {Key? key,
      required this.cardKey,
      required this.overallSpaces,
      required this.leftSpaces,
      required this.streetNumber})
      : super(key: key);

  final GlobalKey<FlipCardState> cardKey;
  final int overallSpaces;
  final int leftSpaces;
  final int streetNumber;

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
                      "This facility offers a nice working environment in a silent area.\nFeatures: Parking area, Coffee, Nature, Great View\nContact: Noah Joeris, +49123456789"),
                ),
                SizedBox(
                  height: 60,
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
                  Text("Street $streetNumber, 64293 Darmstadt"),
                  Text("$leftSpaces/$overallSpaces left")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavouriteButtonState extends State<FavouriteButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                setState(() {
                  widget.status = !widget.status;
                });
              },
              icon: Icon(
                widget.status ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
                size: 40,
              ),
            )),
      ),
    );
  }
}

class FavouriteButton extends StatefulWidget {
  bool status = false;
  FavouriteButton({
    Key? key,
  }) : super(key: key);

  @override
  _FavouriteButtonState createState() => _FavouriteButtonState();
}

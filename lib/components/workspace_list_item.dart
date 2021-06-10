import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flip_card/flip_card.dart';
import 'package:kowoerka/screens/workspace_selector_screen.dart';

//TODO refactor: combine listitems to reduce redundancy
class WorkspaceListItem extends StatelessWidget {
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  final bool isBooked = Random().nextBool();
  final int workspaceNo = Random().nextInt(100);

  @override
  Widget build(BuildContext context) {
    return FlipCard(
        key: cardKey,
        direction: FlipDirection.VERTICAL,
        flipOnTouch: false,
        front: FlipCardFront(
          cardKey: cardKey,
          isBooked: isBooked,
          workspaceNo: workspaceNo,
        ),
        back: FlipCardBack(
          cardKey: cardKey,
          isBooked: isBooked,
          workspaceNo: workspaceNo,
        ));
  }
}

class FlipCardFront extends StatelessWidget {
  const FlipCardFront(
      {Key? key,
      required this.cardKey,
      required this.isBooked,
      required this.workspaceNo})
      : super(key: key);

  final GlobalKey<FlipCardState> cardKey;
  final bool isBooked;
  final int workspaceNo;
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
            Stack(children: [
              FavouriteButton(),
              Ink.image(
                height: 150,
                fit: BoxFit.fitWidth,
                image: AssetImage(
                    "assets/images/workspace${Random().nextInt(5) + 1}.jpg"),
              ),
            ]),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Workspace No $workspaceNo"),
                  Text(isBooked ? "already booked" : "free to book")
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
      required this.isBooked,
      required this.workspaceNo})
      : super(key: key);

  final GlobalKey<FlipCardState> cardKey;
  final bool isBooked;
  final int workspaceNo;

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
                  Text("Workspace No $workspaceNo"),
                  Text(isBooked ? "already booked" : "free to book")
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
                color: widget.status ? Colors.red : Colors.black54,
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

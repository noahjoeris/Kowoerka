import 'dart:ui';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:kowoerka/components/big_home_card.dart';
import 'package:kowoerka/model/location_repository.dart';
import 'package:kowoerka/screens/location_selector_screen.dart';
import 'package:kowoerka/services/locator.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        title: Text("Kowoerka"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            BigHomeCard(
              title: "Start Booking",
              imageName: "booking.png",
              onClick: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LocationSelectorScreen(
                            locator<LocationRepository>().locations)));
              },
            ),
            BigHomeCard(
                imageName: "reservation1.png",
                title: "Reservations",
                onClick: () {}),
            BigHomeCard(
                imageName: "agent.jpg", title: "Be the Agent", onClick: () {}),
          ],
        ),
      ),
    );
  }
}

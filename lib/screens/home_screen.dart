import 'dart:ui';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
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
            Expanded(
                child: Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LocationSelectorScreen(
                                    locator<LocationRepository>().locations)));
                      },
                      child: Stack(children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/booking.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                            child: Container(
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Start Booking",
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ]),
                    ))),
            Expanded(
                child: Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {},
                      child: Stack(children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/reservation1.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                            child: Container(
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Reservations",
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ]),
                    ))),
            Expanded(
                child: Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {},
                      child: Stack(children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/agent.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                            child: Container(
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Be the agent",
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ]),
                    ))),
          ],
        ),
      ),
    );
  }
}

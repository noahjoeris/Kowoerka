import "package:flutter/material.dart";
import 'package:kowoerka/model/location.dart';

class LocationCreator extends StatefulWidget {
  @override
  _LocationCreatorState createState() => _LocationCreatorState();

  Location? _editingLocation;

  LocationCreator([this._editingLocation]);
}

class _LocationCreatorState extends State<LocationCreator> {
  List<String> features = List.empty(growable: true);
  String description = "";
  String postalCode = "";
  String city = "";
  String street = "";
  String houseNumber = "";

  @override
  void initState() {
    super.initState();
    if (widget._editingLocation != null) {
      features = widget._editingLocation!.features;
      postalCode = widget._editingLocation!.postalCode;
      city = widget._editingLocation!.city;
      street = widget._editingLocation!.street;
      houseNumber = widget._editingLocation!.houseNumber;
      description = widget._editingLocation!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        title: widget._editingLocation != null
            ? Column(
                children: [
                  Text("Editing Location"),
                  (Text(
                      "${widget._editingLocation!.street} ${widget._editingLocation!.houseNumber}, ${widget._editingLocation!.city}")),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              )
            : Text("Create a new Location"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}

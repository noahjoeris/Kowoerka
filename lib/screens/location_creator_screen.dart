import 'dart:async';
import 'dart:math';

import 'package:faker/faker.dart';
import "package:flutter/material.dart";
import 'package:kowoerka/model/location.dart';
import 'package:kowoerka/model/location_repository.dart';
import 'package:kowoerka/model/user_repository.dart';
import 'package:kowoerka/screens/home_screen.dart';
import 'package:kowoerka/services/locator.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LocationCreatorScreen extends StatefulWidget {
  @override
  _LocationCreatorScreenState createState() => _LocationCreatorScreenState();

  Location? _editingLocation;

  LocationCreatorScreen([this._editingLocation]);
}

class _LocationCreatorScreenState extends State<LocationCreatorScreen> {
  late TextEditingController _featuresController;
  late TextEditingController _cityController;
  late TextEditingController _streetController;
  late TextEditingController _postalCodeController;
  late TextEditingController _houseNumberController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _descriptionController =
        TextEditingController(text: widget._editingLocation?.description ?? "");
    _cityController =
        TextEditingController(text: widget._editingLocation?.city ?? "");
    _postalCodeController =
        TextEditingController(text: widget._editingLocation?.postalCode ?? "");
    _houseNumberController =
        TextEditingController(text: widget._editingLocation?.houseNumber ?? "");
    _streetController =
        TextEditingController(text: widget._editingLocation?.street ?? "");
    _featuresController = TextEditingController(
        text: widget._editingLocation?.features.join(",") ?? "");
  }

  @override
  Widget build(BuildContext context) {
    final RoundedLoadingButtonController _btnController =
        RoundedLoadingButtonController();

    //TODO: add missing validation
    void saveButtonClicked() async {
      if (widget._editingLocation != null) {
        widget._editingLocation!.description = _descriptionController.text;
        widget._editingLocation!.city = _cityController.text;
        widget._editingLocation!.street = _streetController.text;
        widget._editingLocation!.houseNumber = _houseNumberController.text;
        widget._editingLocation!.postalCode = _postalCodeController.text;
        widget._editingLocation!.features =
            _featuresController.text.split(',').toList(growable: true);
        _btnController.success();

        Timer(Duration(seconds: 2), () {
          _btnController.reset();
          final snackBar = SnackBar(
              elevation: 10,
              duration: Duration(seconds: 4),
              content: Text('Successfully updated'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        });
      } else {
        Location l = Location(
            id: faker.guid.guid(),
            workspaces: List.empty(growable: true),
            imageNumber: Random().nextInt(4) + 1,
            features:
                _featuresController.text.split(',').toList(growable: true),
            realEstateAgent: locator<UserRepository>().getLoggedInUser(),
            description: _descriptionController.text,
            houseNumber: _houseNumberController.text,
            street: _streetController.text,
            postalCode: _postalCodeController.text,
            city: _cityController.text);
        locator<LocationRepository>().locations.add(l);
        _btnController.success();

        Timer(Duration(seconds: 2), () {
          _btnController.reset();
          final snackBar = SnackBar(
              elevation: 10,
              duration: Duration(seconds: 4),
              content: Text('Successfully Added'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: widget._editingLocation != null
            ? Column(
                children: [
                  Text("Edit Location"),
                  (Text(
                    "${widget._editingLocation!.street} ${widget._editingLocation!.houseNumber}, ${widget._editingLocation!.city}",
                    style: TextStyle(
                        //TODO: refactor constants
                        color: Colors.grey,
                        fontSize: 14,
                        fontStyle: FontStyle.italic),
                  )),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              )
            : Text("Create a new Location"),
      ),
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.all(15.0),
          child: ListView(children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "City"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _postalCodeController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Postal Code"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _streetController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Street"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _houseNumberController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "House Number"),
            ),
            SizedBox(height: 20),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Description"),
              controller: _descriptionController,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _featuresController,
              decoration: InputDecoration(
                  helperText: "comma seperated values",
                  border: OutlineInputBorder(),
                  labelText: "Features"),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: RoundedLoadingButton(
              height: 40,
              width: 30,
              loaderSize: 20,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget._editingLocation != null
                      ? 'Save Changes'
                      : "Save new Location",
                ),
              ),
              controller: _btnController,
              onPressed: saveButtonClicked,
            ),
          ),
        ),
      ]),
    );
  }
}

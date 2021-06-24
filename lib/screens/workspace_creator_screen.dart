import 'dart:async';
import 'dart:math';

import 'package:faker/faker.dart';
import "package:flutter/material.dart";
import 'package:kowoerka/model/location.dart';
import 'package:kowoerka/model/location_repository.dart';
import 'package:kowoerka/model/user_repository.dart';
import 'package:kowoerka/model/workspace.dart';
import 'package:kowoerka/screens/home_screen.dart';
import 'package:kowoerka/services/locator.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

//TODO: refactor: combine with locatorCreatorScreen to reduce redundancy
class WorkspaceCreatorScreen extends StatefulWidget {
  @override
  _WorkspaceCreatorScreenState createState() => _WorkspaceCreatorScreenState();

  Workspace? _editingWorkspace;
  Location? _location; // todo: refactor, not an elegant way

  WorkspaceCreatorScreen([this._editingWorkspace, this._location]);
}

class _WorkspaceCreatorScreenState extends State<WorkspaceCreatorScreen> {
  late TextEditingController _featuresController;
  late TextEditingController _pricePerHourController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController(
        text: widget._editingWorkspace?.description ?? "");
    _pricePerHourController = TextEditingController(
        text: widget._editingWorkspace?.pricePerHour.toStringAsFixed(2) ?? "");
    _featuresController = TextEditingController(
        text: widget._editingWorkspace?.features.join(",") ?? "");
  }

  @override
  Widget build(BuildContext context) {
    final RoundedLoadingButtonController _btnController =
        RoundedLoadingButtonController();

    //TODO: add missing validation
    void saveButtonClicked() async {
      if (widget._editingWorkspace != null) {
        widget._editingWorkspace!.description = _descriptionController.text;

        widget._editingWorkspace!.pricePerHour =
            double.parse(_pricePerHourController.text);
        widget._editingWorkspace!.features =
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
        Workspace ws = Workspace(
            id: faker.guid.guid(),
            description: _descriptionController.text,
            imageNumber: Random().nextInt(5) + 1,
            pricePerHour: double.parse(_pricePerHourController.text),
            features:
                _featuresController.text.split(',').toList(growable: true));

        widget._location?.workspaces.add(ws);
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
        title: widget._editingWorkspace != null
            ? Text("Edit Workspace")
            : Text("Create a new Workspace"),
      ),
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.all(15.0),
          child: ListView(children: [
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Description"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _featuresController,
              maxLines: 3,
              decoration: InputDecoration(
                  helperText: "comma seperated values",
                  border: OutlineInputBorder(),
                  labelText: "Features"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _pricePerHourController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Price per hour"),
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
                  widget._editingWorkspace != null
                      ? 'Save Changes'
                      : "Save new Workspace",
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

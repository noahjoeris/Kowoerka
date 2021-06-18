import 'package:flutter/material.dart';
import 'package:kowoerka/components/location_list_item.dart';
import 'package:kowoerka/components/search_app_bar.dart';
import 'package:kowoerka/model/location.dart';
import 'package:kowoerka/model/location_repository.dart';
import 'package:kowoerka/services/locator.dart';

class LocationSelectorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Location> locations = locator<LocationRepository>().locations;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SearchAppBar(
                heading: "Choose a Location",
                backButtonEnabled: false,
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                (context, index) => LocationListItem(locations[index]),
                childCount: locations.length,
              )),
            ],
          ),
        ],
      ),
    );
  }
}

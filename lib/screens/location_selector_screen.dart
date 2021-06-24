import 'package:flutter/material.dart';
import 'package:kowoerka/components/location_list_item.dart';
import 'package:kowoerka/model/location.dart';
import 'package:kowoerka/model/location_repository.dart';
import 'package:kowoerka/model/user_repository.dart';
import 'package:kowoerka/services/locator.dart';

class LocationSelectorScreen extends StatefulWidget {
  final List<Location> _locations;
  final bool _agentViewActive;

  LocationSelectorScreen(this._locations, [this._agentViewActive = false]);

  @override
  _LocationSelectorScreenState createState() => _LocationSelectorScreenState();
}

class _LocationSelectorScreenState extends State<LocationSelectorScreen> {
  bool filterFavouriteActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              title: Text(widget._agentViewActive
                  ? "Your Locations"
                  : "Choose a Location"),
              floating: true,
              pinned: false,
              snap: false,
              elevation: 5,
              expandedHeight: 100,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              bottom: widget._agentViewActive
                  ? null
                  : PreferredSize(
                      preferredSize: Size.fromHeight(30),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FilterChip(
                            label: Text('Favorites'),
                            onSelected: (event) {
                              setState(() {
                                filterFavouriteActive = !filterFavouriteActive;
                              });
                            },
                            selected: filterFavouriteActive,
                            checkmarkColor: Colors.red,
                            elevation: 5,
                          ),
                        ),
                      ),
                    )),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) => filterFavouriteActive
                ? LocationListItem(widget._locations
                    .where((element) => locator<UserRepository>()
                        .getLoggedInUser()
                        .favouriteLocations
                        .any((element2) => element.id == element2.id))
                    .toList()[index])
                : LocationListItem(widget._locations[index]),
            childCount: filterFavouriteActive
                ? widget._locations
                    .where((element) => locator<UserRepository>()
                        .getLoggedInUser()
                        .favouriteLocations
                        .any((element2) => element.id == element2.id))
                    .toList()
                    .length
                : widget._locations.length,
          )),
        ],
      ),
    );
  }
}

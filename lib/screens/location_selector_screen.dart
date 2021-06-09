import 'package:flutter/material.dart';
import 'package:kowoerka/components/location_list_item.dart';
import 'package:kowoerka/components/search_app_bar.dart';

class LocationSelectorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SearchAppBar(),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                (context, index) => LocationListItem(),
                childCount: 1000,
              )),
            ],
          ),
        ],
      ),
    );
  }
}

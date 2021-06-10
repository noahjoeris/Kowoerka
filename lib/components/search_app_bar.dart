import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget {
  final String heading;

  const SearchAppBar({this.heading = "Kowoerka"});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        title: Text(heading),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
            ),
            // iconSize: 26.0,
          )
        ],
        floating: true,
        pinned: false,
        snap: false,
        elevation: 5,
        expandedHeight: 100,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              children: [
                // TextField(),
                FilterChip(
                  label: Text('Popular'),
                  onSelected: (event) {},
                  selected: false,
                  elevation: 5,
                ),
                SizedBox(width: 15),
                FilterChip(
                  label: Text('Favorites'),
                  onSelected: (event) {},
                  selected: false,
                  elevation: 5,
                ),
              ],
            ),
          ),
        ));
  }
}

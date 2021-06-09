import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        title: Text("Choose a Location"),
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
            padding: const EdgeInsets.fromLTRB(5.0, 0, 5, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FilterChip(
                  label: Text('Popular'),
                  onSelected: (event) {},
                  selected: false,
                  elevation: 5,
                ),
                SizedBox(
                  width: 20,
                ),
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

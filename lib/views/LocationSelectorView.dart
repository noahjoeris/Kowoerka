import 'dart:math';
import 'package:flutter/material.dart';

class LocationSelectorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
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
                  )),
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

class LocationListItem extends StatelessWidget {
  const LocationListItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            Stack(children: [
              Image(
                image: AssetImage(
                    "assets/images/location${Random().nextInt(4) + 1}.jpg"),
                width: 300,
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {},
                        child: Icon(
                          Random().nextBool()
                              ? Icons.favorite_border
                              : Icons.favorite,
                          color: Colors.red,
                          size: 40,
                        ),
                      )),
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Street ${Random().nextInt(100)}, 64293 Darmstadt"),
                    Text(
                        "${Random().nextInt(30)}/${Random().nextInt(30) + 30} left")
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

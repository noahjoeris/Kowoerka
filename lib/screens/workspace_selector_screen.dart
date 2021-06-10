import 'package:flutter/material.dart';
import 'package:kowoerka/components/location_list_item.dart';
import 'package:kowoerka/components/search_app_bar.dart';
import 'package:kowoerka/components/workspace_list_item.dart';
import 'package:badges/badges.dart';

class WorkspaceSelectorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SearchAppBar(
                heading: "Choose a Workspace",
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                (context, index) => WorkspaceListItem(),
                childCount: 1000,
              )),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: FloatingActionButton(
                onPressed: () {},
                child: Badge(
                    elevation: 0,
                    badgeContent: Text("4"),
                    badgeColor: Colors.blue, //TODO outsource constants
                    child: Icon(Icons.playlist_add_check_rounded)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

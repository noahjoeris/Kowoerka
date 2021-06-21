import 'package:flutter/material.dart';
import 'package:kowoerka/components/location_list_item.dart';
import 'package:kowoerka/components/search_app_bar.dart';
import 'package:kowoerka/components/workspace_list_item.dart';
import 'package:badges/badges.dart';
import 'package:kowoerka/model/workspace.dart';

class WorkspaceSelectorScreen extends StatelessWidget {
  final List<Workspace> _workspaces;

  WorkspaceSelectorScreen(this._workspaces);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SearchAppBar(
            heading: "Choose a Workspace",
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) => WorkspaceListItem(_workspaces[index]),
            childCount: _workspaces.length,
          )),
        ],
      ),
    );
  }
}

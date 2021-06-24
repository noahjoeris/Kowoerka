import 'package:flutter/material.dart';
import 'package:kowoerka/components/location_list_item.dart';
import 'package:kowoerka/components/workspace_list_item.dart';
import 'package:badges/badges.dart';
import 'package:kowoerka/model/user_repository.dart';
import 'package:kowoerka/model/workspace.dart';
import 'package:kowoerka/services/locator.dart';

class WorkspaceSelectorScreen extends StatefulWidget {
  final List<Workspace> _workspaces;

  WorkspaceSelectorScreen(this._workspaces);

  @override
  _WorkspaceSelectorScreenState createState() =>
      _WorkspaceSelectorScreenState();
}

class _WorkspaceSelectorScreenState extends State<WorkspaceSelectorScreen> {
  bool filterFavouriteActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              title: Text("Choose a workspace"),
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
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(30),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    children: [
                      FilterChip(
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
                    ],
                  ),
                ),
              )),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) => filterFavouriteActive
                ? WorkspaceListItem(widget._workspaces
                    .where((element) => locator<UserRepository>()
                        .getLoggedInUser()
                        .favouriteWorkspaces
                        .any((element2) => element.id == element2.id))
                    .toList()[index])
                : WorkspaceListItem(widget._workspaces[index]),
            childCount: filterFavouriteActive
                ? widget._workspaces
                    .where((element) => locator<UserRepository>()
                        .getLoggedInUser()
                        .favouriteWorkspaces
                        .any((element2) => element.id == element2.id))
                    .toList()
                    .length
                : widget._workspaces.length,
          )),
        ],
      ),
    );
  }
}

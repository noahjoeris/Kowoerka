import 'package:flutter/material.dart';
import 'package:kowoerka/components/location_list_item.dart';
import 'package:kowoerka/components/workspace_list_item.dart';
import 'package:badges/badges.dart';
import 'package:kowoerka/model/location_repository.dart';
import 'package:kowoerka/model/user_repository.dart';
import 'package:kowoerka/model/workspace.dart';
import 'package:kowoerka/services/locator.dart';

class WorkspaceSelectorScreen extends StatefulWidget {
  final List<Workspace> _workspaces;
  final bool _agentViewActive;

  WorkspaceSelectorScreen(this._workspaces, [this._agentViewActive = false]);

  @override
  _WorkspaceSelectorScreenState createState() =>
      _WorkspaceSelectorScreenState();
}

class _WorkspaceSelectorScreenState extends State<WorkspaceSelectorScreen> {
  bool filterFavouriteActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
                title: widget._agentViewActive
                    ? Column(
                        children: [
                          Text("Your Workspaces"),
                          widget._workspaces.isNotEmpty
                              ? (Text(
                                  locator<LocationRepository>()
                                      .getAddressForWorkspace(
                                          widget._workspaces.first),
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic),
                                ))
                              : Container(),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      )
                    : Text("Choose a Workspace"),
                floating: true,
                pinned: false,
                snap: false,
                elevation: 5,
                expandedHeight: widget._agentViewActive ? 0 : 100,
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
                          child: Row(
                            children: [
                              FilterChip(
                                label: Text('Favorites'),
                                onSelected: (event) {
                                  setState(() {
                                    filterFavouriteActive =
                                        !filterFavouriteActive;
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
                  ? WorkspaceListItem(
                      widget._workspaces
                          .where((element) => locator<UserRepository>()
                              .getLoggedInUser()
                              .favouriteWorkspaces
                              .any((element2) => element.id == element2.id))
                          .toList()[index],
                      widget._agentViewActive)
                  : WorkspaceListItem(
                      widget._workspaces[index], widget._agentViewActive),
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
        widget._agentViewActive
            ? Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: FloatingActionButton(
                      child: Icon(Icons.add), onPressed: () {}),
                ))
            : Container(),
      ]),
    );
  }
}

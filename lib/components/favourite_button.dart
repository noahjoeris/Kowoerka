import "package:flutter/material.dart";
import 'package:kowoerka/model/user_repository.dart';
import 'package:kowoerka/model/workspace.dart';
import 'package:kowoerka/services/locator.dart';

class FavouriteButton extends StatefulWidget {
  bool active;
  Function onActivated;
  Function onInactivated;

  FavouriteButton({
    Key? key,
    required this.active,
    required this.onActivated,
    required this.onInactivated,
  }) : super(key: key);

  @override
  _FavouriteButtonState createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                if (widget.active)
                  widget.onInactivated();
                else
                  widget.onActivated();
                setState(() {
                  widget.active = !widget.active;
                });
              },
              icon: Icon(
                widget.active ? Icons.favorite : Icons.favorite_border,
                color: widget.active ? Colors.red : Colors.black54,
                size: 40,
              ),
            )),
      ),
    );
  }
}

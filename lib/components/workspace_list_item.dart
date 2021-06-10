import 'package:day_night_time_picker/lib/constants.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flip_card/flip_card.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';

//TODO refactor: combine listitems to reduce redundancy
class WorkspaceListItem extends StatelessWidget {
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  final bool isBooked = Random().nextBool();
  final int workspaceNo = Random().nextInt(100);

  @override
  Widget build(BuildContext context) {
    return FlipCard(
        key: cardKey,
        direction: FlipDirection.HORIZONTAL,
        flipOnTouch: false,
        front: FlipCardFront(
          cardKey: cardKey,
          isBooked: isBooked,
          workspaceNo: workspaceNo,
        ),
        back: FlipCardBack(
          cardKey: cardKey,
          isBooked: isBooked,
          workspaceNo: workspaceNo,
        ));
  }
}

class FlipCardFront extends StatelessWidget {
  const FlipCardFront(
      {Key? key,
      required this.cardKey,
      required this.isBooked,
      required this.workspaceNo})
      : super(key: key);

  final GlobalKey<FlipCardState> cardKey;
  final bool isBooked;
  final int workspaceNo;
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          cardKey.currentState?.toggleCard();
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              FavouriteButton(),
              Ink.image(
                height: 150,
                fit: BoxFit.fitWidth,
                image: AssetImage(
                    "assets/images/workspace${Random().nextInt(5) + 1}.jpg"),
              ),
            ]),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Workspace No $workspaceNo"),
                  Text(isBooked ? "already booked" : "free to book")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//TODO create own component widget
class FlipCardBack extends StatelessWidget {
  const FlipCardBack(
      {Key? key,
      required this.cardKey,
      required this.isBooked,
      required this.workspaceNo})
      : super(key: key);

  final GlobalKey<FlipCardState> cardKey;
  final bool isBooked;
  final int workspaceNo;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          cardKey.currentState?.toggleCard();
        },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "This workspace has everything you need to work as productively as possible.\n\nFeatures: Height adjustable desk, Monitor(4k), Power supply, Lamp\n\nContact: Noah Joeris, +49123456789"),
                  Divider(),
                  Text(
                    "Book",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  TimeRangePicker(),
                ],
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text("Workspace No $workspaceNo"),
            //       Text(isBooked ? "already booked" : "free to book")
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
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
                setState(() {
                  widget.status = !widget.status;
                });
              },
              icon: Icon(
                widget.status ? Icons.favorite : Icons.favorite_border,
                color: widget.status ? Colors.red : Colors.black54,
                size: 40,
              ),
            )),
      ),
    );
  }
}

class TimeRangePicker extends StatefulWidget {
  @override
  _TimeRangePickerState createState() => _TimeRangePickerState();
}

class _TimeRangePickerState extends State<TimeRangePicker> {
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  bool iosStyle = true;

  void onStartTimeChanged(TimeOfDay newTime) {
    setState(() {
      _startTime = newTime;
    });
  }

  void onEndTimeChanged(TimeOfDay newTime) {
    setState(() {
      _endTime = newTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              showPicker(
                context: context,
                value: _startTime,
                onChange: onStartTimeChanged,
                disableHour: false,
                disableMinute: false,
                is24HrFormat: true,
                minuteInterval: MinuteInterval.ONE,
              ),
            );
          },
          child: Text("Start Time: ${_startTime.hour}:${_startTime.minute}"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              showPicker(
                context: context,
                value: _endTime,
                onChange: onEndTimeChanged,
                disableHour: false,
                disableMinute: false,
                is24HrFormat: true,
                minuteInterval: MinuteInterval.ONE,
              ),
            );
          },
          child: Text("End Time: ${_endTime.hour}:${_endTime.minute}"),
        ),
      ],
    );
  }
}

class FavouriteButton extends StatefulWidget {
  bool status = false;
  FavouriteButton({
    Key? key,
  }) : super(key: key);

  @override
  _FavouriteButtonState createState() => _FavouriteButtonState();
}

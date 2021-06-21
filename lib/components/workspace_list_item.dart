import 'dart:async';

import 'package:day_night_time_picker/lib/constants.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flip_card/flip_card.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:kowoerka/model/reservation.dart';
import 'package:kowoerka/model/reservation_repository.dart';
import 'package:kowoerka/model/reservation_repository.dart';
import 'package:kowoerka/model/user_repository.dart';
import 'package:kowoerka/model/workspace.dart';
import 'package:kowoerka/services/locator.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

//TODO refactor: combine listitems to reduce redundancy
class WorkspaceListItem extends StatelessWidget {
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  final Workspace _workspace;

  WorkspaceListItem(this._workspace);

  // late String isBookedMessage = createIsBookedMessage();
  //
  // String createIsBookedMessage() {
  //   List<Reservation> res = locator<ReservationRepository>().reservations;
  //   if (!res.any((element) => element.workspaceID == _workspace.id)) {
  //     return "free to book";
  //   }
  //
  //   if (res.any((element) =>
  //       element.workspaceID == _workspace.id &&
  //       element.dateTimeStart.isAfter(DateTime.now()))) {
  //     return "upcoming reservations";
  //   }
  //   return "UNDEFINED";
  // }

  @override
  Widget build(BuildContext context) {
    return FlipCard(
        key: cardKey,
        direction: FlipDirection.HORIZONTAL,
        flipOnTouch: false,
        front: FlipCardFront(
          cardKey: cardKey,
          workspace: _workspace,
        ),
        back: FlipCardBack(
          cardKey: cardKey,
          workspace: _workspace,
        ));
  }
}

class FlipCardFront extends StatelessWidget {
  FlipCardFront({Key? key, required this.cardKey, required this.workspace})
      : super(key: key);

  final GlobalKey<FlipCardState> cardKey;
  final Workspace workspace;
  final ReservationRepository reservationRepo =
      locator<ReservationRepository>();

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
                height: 230,
                fit: BoxFit.fitWidth,
                image: AssetImage(
                    "assets/images/workspace${workspace.imageNumber}.jpg"),
              ),
            ]),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "${workspace.pricePerHour.toStringAsFixed(2)}€ per hour"),
                  Text(reservationRepo
                              .getCurrentWorkspaceReservation(workspace.id) !=
                          null
                      ? "currently booked"
                      : "free to book"),
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
  const FlipCardBack({
    Key? key,
    required this.cardKey,
    required this.workspace,
  }) : super(key: key);

  final GlobalKey<FlipCardState> cardKey;
  final Workspace workspace;

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
                children: [
                  Text(
                      "${workspace.description}\n\nFeatures: ${workspace.features}"),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Book",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                      Text(
                          "${workspace.pricePerHour.toStringAsFixed(2)}€ per hour"),
                    ],
                  ),
                  BookingArea(workspace),
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

//TODO refactor
class BookingArea extends StatefulWidget {
  @override
  _BookingAreaState createState() => _BookingAreaState();
  final Workspace _workspace;

  BookingArea(this._workspace);
}

class _BookingAreaState extends State<BookingArea> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  DateTimeRange? _dateRange;

  bool iosStyle = false;

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

  void addToReservationsClicked() async {
    bool isAvailable = false;
    if (_dateRange == null) {
      _btnController.error();
      Timer(Duration(seconds: 2), () {
        _btnController.reset();
      });
      return;
    }
    var r = Reservation(
        id: faker.guid.guid(),
        dateTimeStart: DateTime(_dateRange!.start.year, _dateRange!.start.month,
            _dateRange!.start.day, _startTime.hour, _startTime.minute),
        dateTimeEnd: DateTime(_dateRange!.end.year, _dateRange!.end.month,
            _dateRange!.end.day, _endTime.hour, _endTime.minute),
        pricePerHour: widget._workspace.pricePerHour,
        workspaceID: widget._workspace.id,
        user: locator<UserRepository>().getLoggedInUser());

    // add delay for test purposes
    Timer(Duration(seconds: 1), () {
      if (locator<ReservationRepository>().isAvailable(r)) {
        locator<ReservationRepository>().reservations.add(r);
        _btnController.success();
      } else
        _btnController.error();
    });
    //reset result
    Timer(Duration(seconds: 3), () {
      _btnController.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
            onPressed: () async {
              final DateTimeRange? result = await showDateRangePicker(
                  context: context,
                  initialDateRange: _dateRange,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)));
              setState(() {
                _dateRange = result;
              });
            },
            child: Text(_dateRange != null
                ? "${_dateRange?.start.day}.${_dateRange?.start.month}.${_dateRange?.start.year} - ${_dateRange?.end.day}.${_dateRange?.end.month}.${_dateRange?.end.year}"
                : "Select a date")),
        Row(
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
                    minuteInterval: MinuteInterval.FIVE,
                  ),
                );
              },
              child:
                  Text("Start Time: ${_startTime.hour}:${_startTime.minute}"),
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
                    minuteInterval: MinuteInterval.FIVE,
                  ),
                );
              },
              child: Text("End Time: ${_endTime.hour}:${_endTime.minute}"),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(onPressed: () {}, child: Text("See Reservations")),
            RoundedLoadingButton(
              height: 40,
              width: 30,
              loaderSize: 20,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Add to reservations',
                ),
              ),
              controller: _btnController,
              onPressed: addToReservationsClicked,
            ),
          ],
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

// ignore_for_file: file_names

import 'package:flutter/material.dart';

class StartingListCell extends StatefulWidget {
  final String startingTime;
  final String name;
  final String surname;
  const StartingListCell(this.startingTime, this.name, this.surname, {Key? key})
      : super(key: key);

  @override
  State<StartingListCell> createState() => _StartingListCellState();
}

class _StartingListCellState extends State<StartingListCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Center(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AthleteNameAndSurname(widget: widget),
                      AthleteStartingTime(widget: widget),
                    ],
                  ),
                  const PaleDivider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PaleDivider extends StatelessWidget {
  const PaleDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Color.fromARGB(127, 0, 0, 0),
    );
  }
}

class AthletePosition extends StatelessWidget {
  const AthletePosition({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final StartingListCell widget;

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.startingTime.contains("arrived")
          ? 'n/a'
          : '${widget.startingTime}°',
      style: const TextStyle(fontSize: 30),
    );
  }
}

class AthleteStartingTime extends StatelessWidget {
  const AthleteStartingTime({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final StartingListCell widget;

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.startingTime,
      style: const TextStyle(
        fontSize: 17,
        fontStyle: FontStyle.italic,
        color: Color.fromARGB(128, 0, 0, 0),
      ),
    );
  }
}

class AthleteNameAndSurname extends StatelessWidget {
  const AthleteNameAndSurname({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final StartingListCell widget;

  @override
  Widget build(BuildContext context) {
    return Text(
      "${widget.name} ${widget.surname}",
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

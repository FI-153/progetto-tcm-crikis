// ignore_for_file: file_names

import 'package:Orienteering/Utilities/costum_icons_icons.dart';
import 'package:flutter/material.dart';

class RankCell extends StatefulWidget {
  final String position;
  final String name;
  final String surname;
  const RankCell(this.position, this.name, this.surname, {Key? key})
      : super(key: key);

  @override
  State<RankCell> createState() => _RankCellState();
}

class _RankCellState extends State<RankCell> {
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AthleteName(widget: widget),
                              showCrownWhenNeeded(widget.position)
                            ],
                          ),
                          AthleteSurname(widget: widget),
                        ],
                      ),
                      AthletePosition(widget: widget),
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

  Icon showCrownWhenNeeded(String position) {
    if (position.contains("arrived")) {
      return const Icon(Icons.abc, size: 0);
    }

    if (int.parse(position) < 1) {
      return const Icon(Icons.abc, size: 0);
    }

    return const Icon(
      CostumIcons.crown,
      size: 10,
      color: Colors.amber,
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

  final RankCell widget;

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.position.contains("arrived") ? 'n/a' : '${widget.position}°',
      style: const TextStyle(fontSize: 30),
    );
  }
}

class AthleteSurname extends StatelessWidget {
  const AthleteSurname({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final RankCell widget;

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.surname,
      style: const TextStyle(
        fontSize: 17,
        fontStyle: FontStyle.italic,
        color: Color.fromARGB(128, 0, 0, 0),
      ),
    );
  }
}

class AthleteName extends StatelessWidget {
  const AthleteName({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final RankCell widget;

  @override
  Widget build(BuildContext context) {
    return Text(
      "${widget.name} ",
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

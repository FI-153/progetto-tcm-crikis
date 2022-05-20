import 'package:flutter/material.dart';

class RaceCell extends StatefulWidget {
  String raceName;
  String raceDate;
  RaceCell(this.raceName, this.raceDate, {Key? key}) : super(key: key);

  @override
  State<RaceCell> createState() => _RaceCellState();
}

class _RaceCellState extends State<RaceCell> {
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
                    children: [
                      Column(
                        children: [
                          Text(
                            widget.raceName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            widget.raceDate,
                            style: const TextStyle(
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              color: Color.fromARGB(128, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.star,
                        color: Color.fromARGB(255, 222, 222, 0),
                        size: 50,
                      ),
                    ],
                  ),
                  const Divider(
                    color: Color.fromARGB(0, 0, 0, 0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

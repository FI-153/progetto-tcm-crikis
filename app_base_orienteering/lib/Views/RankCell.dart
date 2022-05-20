import 'package:flutter/material.dart';

class RankCell extends StatefulWidget {
  String position;
  String name;
  String surname;
  RankCell(this.position, this.name, this.surname, {Key? key})
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
                    children: [
                      Column(
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            widget.surname,
                            style: const TextStyle(
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              color: Color.fromARGB(128, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        widget.position == "Not arrived" ? '' : widget.position,
                        style: const TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Color.fromARGB(127, 0, 0, 0),
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

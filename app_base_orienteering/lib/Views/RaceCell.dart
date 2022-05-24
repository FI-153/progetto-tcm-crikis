// ignore_for_file: file_names

import 'package:Orienteering/Utilities/costum_icons_icons.dart';
import 'package:flutter/material.dart';
import '../Managers/FavoritesManager.dart';

class RaceCell extends StatefulWidget {
  final String raceName;
  final String raceDate;
  final String raceId;
  const RaceCell(this.raceName, this.raceDate, this.raceId, {Key? key})
      : super(key: key);

  @override
  State<RaceCell> createState() => _RaceCellState();
}

class _RaceCellState extends State<RaceCell> {
  final FavoritesManager _favoritesManager = FavoritesManager.getShared;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            color: Colors.black26,
          ),
        ],
      ),
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
                      RaceName(widget: widget),
                      RaceDate(widget: widget),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      changeFavoriteStatus(widget.raceId);
                    },
                    icon: getIcon(),
                    color: Colors.redAccent,
                    iconSize: 30,
                  ),
                ],
              ),
              const InvisibleDivider(),
            ],
          ),
        ),
      ),
    );
  }

  Icon getIcon() {
    return _favoritesManager.isFavorite(widget.raceId)
        ? const Icon(CostumIcons.heart)
        : const Icon(CostumIcons.heart_empty);
  }

  void changeFavoriteStatus(String raceId) {
    setState(() {
      if (_favoritesManager.isFavorite(raceId)) {
        _favoritesManager.removeFromFavorites(raceId);
      } else {
        _favoritesManager.addToFavorites(raceId);
      }
    });
  }
}

class InvisibleDivider extends StatelessWidget {
  const InvisibleDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Color.fromARGB(0, 0, 0, 0),
    );
  }
}

class RaceDate extends StatelessWidget {
  const RaceDate({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final RaceCell widget;

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.raceDate,
      style: const TextStyle(
        fontSize: 17,
        fontStyle: FontStyle.italic,
        color: Color.fromARGB(128, 0, 0, 0),
      ),
    );
  }
}

class RaceName extends StatelessWidget {
  const RaceName({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final RaceCell widget;

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.raceName,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

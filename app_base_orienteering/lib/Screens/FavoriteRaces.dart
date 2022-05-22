import 'dart:async';
import 'package:app_base_orienteering/Managers/DownloadManager.dart';
import 'package:app_base_orienteering/Screens/Clubs/ClubsRoute.dart';
import 'package:app_base_orienteering/Views/RaceCell.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'Classes/ClassesRoute.dart';
import 'package:focused_menu/focused_menu.dart';
import '../Utilities/costum_icons_icons.dart';

class FavoriteRaces extends StatefulWidget {
  FavoriteRaces({Key? key}) : super(key: key);

  @override
  _FavoriteRacesState createState() => _FavoriteRacesState();
}

class _FavoriteRacesState extends State<FavoriteRaces> {
  ///Stores the races once downloaded
  late Future<List<Map<String, dynamic>>> futureRaces;

  var downloadManager = DownloadManager.getShared;

  @override
  void initState() {
    super.initState();
    fetchFavoriteRaces();
  }

  void fetchFavoriteRaces() async {
    futureRaces = downloadManager.fetchFavoriteRaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Races'),
      ),
      body: Center(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: futureRaces,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            if (snapshot.hasData) {
              var races = snapshot.data!; //force unwrapping after a check

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: races.length,
                itemBuilder: ((context, index) => Padding(
                      padding: const EdgeInsets.all(8),
                      child: FocusedMenuHolder(
                        duration: const Duration(milliseconds: 100),
                        menuWidth: MediaQuery.of(context).size.width * 0.75,
                        menuOffset: 8,
                        blurBackgroundColor:
                            const Color.fromRGBO(204, 204, 204, 0.1),
                        blurSize: 2,
                        onPressed: () {
                          goToRaceClasses(context, races, index);
                        },
                        menuItems: <FocusedMenuItem>[
                          FocusedMenuItem(
                            title: const Text(
                              "Show Rankings by Club",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            trailingIcon: const Icon(CostumIcons.podium),
                            onPressed: () {
                              goToClubs(context, races, index);
                            },
                          ),
                          showStartingList(),
                        ],
                        child: RaceCell(
                          races[index]["race_name"],
                          races[index]["race_data"],
                          races[index]["race_id"],
                        ),
                      ),
                    )),
              );
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            fetchFavoriteRaces();
          });
        },
        label: const Text('Refresh Races'),
        icon: const Icon(Icons.replay),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  void goToClubs(
      BuildContext context, List<Map<String, dynamic>> races, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ClubsRoute(races[index]["race_id"])),
    );
  }

  FocusedMenuItem showStartingList() {
    return FocusedMenuItem(
      title: const Text(
        "Show Starting List",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      trailingIcon: const Icon(CostumIcons.flag),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Text('Starting')),
        );
      },
    );
  }

  void goToRaceClasses(
      BuildContext context, List<Map<String, dynamic>> races, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ClassesRoute(races[index]["race_name"])),
    );
  }
}

// ignore_for_file: file_names, library_private_types_in_public_api

import 'dart:async';
import 'package:app_base_orienteering/Managers/DownloadManager.dart';
import 'package:app_base_orienteering/Screens/Clubs/ClubsRoute.dart';
import 'package:app_base_orienteering/Screens/StartingList.dart';
import 'package:app_base_orienteering/Views/RaceCell.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'Classes/ClassesRoute.dart';
import 'package:focused_menu/focused_menu.dart';
import '../Utilities/costum_icons_icons.dart';
import '../Views/LoadingView.dart';

class AllRaces extends StatefulWidget {
  const AllRaces({Key? key}) : super(key: key);

  @override
  _AllRacesState createState() => _AllRacesState();
}

class _AllRacesState extends State<AllRaces> {
  ///Stores the races once downloaded
  late Future<List<Map<String, dynamic>>> futureRaces;

  var downloadManager = DownloadManager.getShared;

  @override
  void initState() {
    super.initState();
    fetchallRaces();
  }

  void fetchallRaces() async {
    futureRaces = downloadManager.fetchRaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Races'),
      ),
      body: Center(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: futureRaces,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            if (!snapshot.hasData) {
              return const LoadingView();
            }

            if (downloadManager.isLoading) {
              return const LoadingView();
            }

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
                        FocusedMenuItem(
                          title: const Text(
                            "Show Starting List",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          trailingIcon: const Icon(CostumIcons.flag),
                          onPressed: () {
                            goToStartingList(context, races, index);
                          },
                        ),
                      ],
                      child: RaceCell(
                        races[index]["race_name"],
                        races[index]["race_data"],
                        races[index]["race_id"],
                      ),
                    ),
                  )),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            fetchallRaces();
          });
        },
        label: const Text('Refresh Races'),
        icon: const Icon(Icons.replay),
        backgroundColor: const Color.fromARGB(255, 154, 213, 186),
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

  void goToStartingList(
      BuildContext context, List<Map<String, dynamic>> races, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => StartingList(races[index]["race_id"])),
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

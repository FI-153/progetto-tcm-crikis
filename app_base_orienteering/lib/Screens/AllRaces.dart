import 'dart:async';
import 'package:app_base_orienteering/Managers/DownloadManager.dart';
import 'package:app_base_orienteering/Views/RaceCell.dart';
import 'package:flutter/material.dart';
import 'Classes.dart';

class AllRaces extends StatefulWidget {
  bool isDisplayingFavorites;
  AllRaces(this.isDisplayingFavorites, {Key? key}) : super(key: key);

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
    if (widget.isDisplayingFavorites) {
      fetchFavoriteRaces();
    } else {
      fetchallRaces();
    }
  }

  void fetchallRaces() async {
    futureRaces = downloadManager.fetchRaces();
  }

  void fetchFavoriteRaces() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available races'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: futureRaces,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var races = snapshot.data!; //force unwrapping after a check

                return ListView.builder(
                  itemCount: races.length,
                  itemBuilder: ((context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ClassesRoute(races[index]["race_name"]),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                          child: RaceCell(
                            races[index]["race_name"],
                            races[index]["race_data"],
                          ),
                        ),
                      )),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
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
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}

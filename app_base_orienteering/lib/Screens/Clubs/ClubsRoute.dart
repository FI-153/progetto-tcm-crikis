import 'dart:async';
import 'package:app_base_orienteering/Managers/DownloadManager.dart';
import 'package:app_base_orienteering/Screens/Classes/ClassRanking.dart';
import 'package:app_base_orienteering/Screens/Clubs/clubsRanking.dart';
import 'package:flutter/material.dart';

class ClubsRoute extends StatefulWidget {
  final String raceid;
  const ClubsRoute(this.raceid, {Key? key}) : super(key: key);

  @override
  _ClubsRouteState createState() => _ClubsRouteState();
}

class _ClubsRouteState extends State<ClubsRoute> {
  ///Stores the classes once downloaded
  late Future<List<String>> futureClubs;

  var downloadManager = DownloadManager.getShared;

  @override
  void initState() {
    super.initState();
    fetchClubs(widget.raceid);
  }

  void fetchClubs(String raceid) async {
    futureClubs = downloadManager.fetchClubs(raceid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clubs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: FutureBuilder<List<String>>(
            future: futureClubs,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }

              List<String> downloadedClasses = snapshot.data!;
              return ListView.builder(
                itemCount: downloadedClasses.length,
                itemBuilder: ((context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClubsRanking(
                                  widget.raceid, downloadedClasses[index]),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            downloadedClasses[index],
                            textScaleFactor: 1.4,
                          ),
                        ),
                      ),
                    )),
              );

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

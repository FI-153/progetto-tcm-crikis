import 'dart:async';
import 'package:app_base_orienteering/Managers/DownloadManager.dart';
import 'package:app_base_orienteering/Screens/ClassRanking.dart';
import 'package:flutter/material.dart';

class ClassesRoute extends StatefulWidget {
  final String raceid;
  const ClassesRoute(this.raceid, {Key? key}) : super(key: key);

  @override
  _ClassesRouteState createState() => _ClassesRouteState();
}

class _ClassesRouteState extends State<ClassesRoute> {
  ///Stores the classes once downloaded
  late Future<List<String>> futureClasses;

  var downloadManager = DownloadManager.getShared;

  @override
  void initState() {
    super.initState();
    fetchClasses(widget.raceid);
  }

  void fetchClasses(String raceid) async {
    futureClasses = downloadManager.fetchClasses(raceid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: FutureBuilder<List<String>>(
            future: futureClasses,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
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
                                builder: (context) => ClassRanking(
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
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

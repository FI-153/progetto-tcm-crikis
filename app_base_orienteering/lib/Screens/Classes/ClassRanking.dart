import 'package:app_base_orienteering/Views/RankCell.dart';
import 'package:flutter/material.dart';
import '../../Managers/DownloadManager.dart';

class ClassRanking extends StatefulWidget {
  const ClassRanking(this.raceid, this.displayedClass, {Key? key})
      : super(key: key);
  final String raceid;
  final String displayedClass;

  @override
  State<ClassRanking> createState() => _ClassRankingState();
}

class _ClassRankingState extends State<ClassRanking> {
  late Future<List<dynamic>> futureClassRanks;

  var downloadManager = DownloadManager.getShared;

  @override
  void initState() {
    super.initState();
    fetchRanking(widget.raceid, widget.displayedClass);
  }

  void fetchRanking(String raceid, String displayedClass) async {
    futureClassRanks = downloadManager.fetchRankings(raceid, displayedClass);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.displayedClass),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            fetchRanking(widget.raceid, widget.displayedClass);
          });
        },
        label: const Text('Refresh Ranking'),
        icon: const Icon(Icons.replay),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: FutureBuilder<List<dynamic>>(
            future: futureClassRanks,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<dynamic> downloadedRanks = snapshot.data!;

                return ListView.builder(
                  itemCount: downloadedRanks.length,
                  itemBuilder: ((context, index) => RankCell(
                        downloadedRanks[index]['position'],
                        downloadedRanks[index]['name'],
                        downloadedRanks[index]['surname'],
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

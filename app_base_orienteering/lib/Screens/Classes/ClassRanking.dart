// ignore_for_file: file_names

import 'package:app_base_orienteering/Views/RankCell.dart';
import 'package:flutter/material.dart';
import '../../Managers/DownloadManager.dart';
import '../../Views/EmptyView.dart';
import '../../Views/LoadingView.dart';

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
        title: Text('${widget.displayedClass}, Rankings'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            fetchRanking(widget.raceid, widget.displayedClass);
          });
        },
        label: const Text('Refresh Ranking'),
        icon: const Icon(Icons.replay),
        backgroundColor: const Color.fromARGB(255, 154, 213, 186),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: FutureBuilder<List<dynamic>>(
            future: futureClassRanks,
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

              List<dynamic> downloadedRanks = snapshot.data!;
              if (downloadedRanks.isEmpty) {
                return const EmptyView('Maybe the results are not in yet?');
              }

              return ListView.builder(
                itemCount: downloadedRanks.length,
                itemBuilder: ((context, index) => RankCell(
                      downloadedRanks[index]['position'],
                      downloadedRanks[index]['name'],
                      downloadedRanks[index]['surname'],
                    )),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: file_names

import 'package:Orienteering/Utilities/custumTheming.dart';
import 'package:Orienteering/Views/EmptyView.dart';
import 'package:Orienteering/Views/RankCell.dart';
import 'package:flutter/material.dart';
import '../../Managers/DownloadManager.dart';
import '../../Views/LoadingView.dart';

class ClubsRanking extends StatefulWidget {
  const ClubsRanking(this.raceid, this.displayedClub, {Key? key})
      : super(key: key);
  final String raceid;
  final String displayedClub;

  @override
  State<ClubsRanking> createState() => _ClubsRankingState();
}

class _ClubsRankingState extends State<ClubsRanking> {
  late Future<List<dynamic>> futureClubRanks;
  var downloadManager = DownloadManager.getShared;

  @override
  void initState() {
    super.initState();
    fetchRankingForClub(widget.raceid, widget.displayedClub);
  }

  void fetchRankingForClub(String raceid, String displayedClub) async {
    futureClubRanks =
        downloadManager.fetchRankingsForClub(raceid, displayedClub);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.displayedClub}, Rankings"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            fetchRankingForClub(widget.raceid, widget.displayedClub);
          });
        },
        label: const Text('Refresh Ranking'),
        icon: const Icon(Icons.replay),
        backgroundColor: orienteeringGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: FutureBuilder<List<dynamic>>(
            future: futureClubRanks,
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
                return const EmptyView('Maybe the rankings are in yet?');
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

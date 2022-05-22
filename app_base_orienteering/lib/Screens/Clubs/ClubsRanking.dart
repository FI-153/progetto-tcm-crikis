import 'package:app_base_orienteering/Views/RankCell.dart';
import 'package:flutter/material.dart';
import '../../Managers/DownloadManager.dart';

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

  @override
  void initState() {
    super.initState();
    fetchRankingForClub(widget.raceid, widget.displayedClub);
  }

  void fetchRankingForClub(String raceid, String displayedClub) async {
    var downloadManager = DownloadManager.getShared;
    futureClubRanks =
        downloadManager.fetchRankingsForClub(raceid, displayedClub);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.displayedClub),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            fetchRankingForClub(widget.raceid, widget.displayedClub);
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
            future: futureClubRanks,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }

              List<dynamic> downloadedRanks = snapshot.data!;

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
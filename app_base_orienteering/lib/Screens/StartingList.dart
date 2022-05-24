// ignore_for_file: file_names

import 'package:app_base_orienteering/Views/LoadingView.dart';
import 'package:app_base_orienteering/Views/StartingListCell.dart';
import 'package:flutter/material.dart';
import '../Managers/DownloadManager.dart';
import '../Views/EmptyView.dart';

class StartingList extends StatefulWidget {
  const StartingList(this.raceid, {Key? key}) : super(key: key);
  final String raceid;

  @override
  State<StartingList> createState() => _StartingListState();
}

class _StartingListState extends State<StartingList> {
  late Future<List<dynamic>> futureStartingList;

  var downloadManager = DownloadManager.getShared;

  @override
  void initState() {
    super.initState();
    fetchStartingList(widget.raceid);
  }

  void fetchStartingList(String raceid) async {
    setState(() {
      futureStartingList = downloadManager.fetchStartingList(raceid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Starting List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: FutureBuilder<List<dynamic>>(
            future: futureStartingList,
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
                return const EmptyView(
                    'Maybe this race has not been added yet?');
              }

              return ListView.builder(
                itemCount: downloadedRanks.length,
                itemBuilder: ((context, index) => StartingListCell(
                      downloadedRanks[index]['startTime'],
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

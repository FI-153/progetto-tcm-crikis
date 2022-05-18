import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Utilities/globals.dart';

class DownloadManager {
  static DownloadManager shared = DownloadManager();

  ///Gets the shared instance of the DownloadManager
  static DownloadManager getShared() {
    return shared;
  }

  Future<List<Map<String, dynamic>>> fetchRaces() async {
    final response = await http.get(Uri.parse("$apiUrl/list_races"));

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load races.');
    }
  }

  Future<List<String>> fetchClasses(String raceid) async {
    final response =
        await http.get(Uri.parse('$apiUrl/list_classes?race_id=$raceid'));

    if (response.statusCode == 200) {
      return List<String>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load classes.');
    }
  }
}

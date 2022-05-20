import 'package:app_base_orienteering/Managers/FavoritesManager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Utilities/globals.dart';

class DownloadManager {
  DownloadManager._privateConstructor();

  ///The shared instance of the DownloadManager
  static final DownloadManager _shared = DownloadManager._privateConstructor();

  ///Gets the shared instance of the DownloadManager
  static DownloadManager get getShared => _shared;

  ///Fetches all the races
  Future<List<Map<String, dynamic>>> fetchRaces() async {
    final response = await http.get(Uri.parse("$apiUrl/list_races"));

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load races.');
    }
  }

  FavoritesManager favoritesManager = FavoritesManager.getShared;

  Future<List<Map<String, dynamic>>> fetchFavoriteRaces() async {
    String favorites = favoritesManager.getArrayOfFavoriteRaces();

    final response = await http
        .get(Uri.parse("$apiUrl/ranking_from_id_race?race_id=$favorites"));

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load races.');
    }
  }

  ///Fetched all the classes ralative to a race
  Future<List<String>> fetchClasses(String raceid) async {
    final response =
        await http.get(Uri.parse('$apiUrl/list_classes?race_id=$raceid'));

    if (response.statusCode == 200) {
      return List<String>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load classes.');
    }
  }

  ///Fetched all the rankings ralative to a class
  Future<List<dynamic>> fetchRankings(
      String raceid, String displayedClass) async {
    final response = await http.get(
        Uri.parse('$apiUrl/results?race_id=$raceid&className=$displayedClass'));

    if (response.statusCode == 200) {
      return List<dynamic>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load rankings.');
    }
  }
}

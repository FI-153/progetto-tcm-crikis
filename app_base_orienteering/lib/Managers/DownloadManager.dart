// ignore_for_file: file_names

import 'package:Orienteering/Managers/FavoritesManager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Utilities/globals.dart';

class DownloadManager {
  DownloadManager._privateConstructor();

  ///The shared instance of the DownloadManager
  static final DownloadManager _shared = DownloadManager._privateConstructor();

  ///Gets the shared instance of the DownloadManager
  static DownloadManager get getShared => _shared;

  ///Determines is data is being downloaded
  bool isLoading = false;

  ///Fetches all the races
  Future<List<Map<String, dynamic>>> fetchRaces() async {
    isLoading = true;
    final response = await http.get(Uri.parse("$apiUrl/list_races"));
    isLoading = false;

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load races.');
    }
  }

  ///Fetches only the favorite races given the list in FavoritesManager
  Future<List<Map<String, dynamic>>> fetchFavoriteRaces() async {
    FavoritesManager favoritesManager = FavoritesManager.getShared;
    String favorites = favoritesManager.getArrayOfFavoriteRaces();

    isLoading = true;
    final response = await http
        .get(Uri.parse("$apiUrl/ranking_from_id_race?race_id=$favorites"));
    isLoading = false;

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load races.');
    }
  }

  ///Fetches all the classes ralative to a race
  Future<List<String>> fetchClasses(String raceid) async {
    final response =
        await http.get(Uri.parse('$apiUrl/list_classes?race_id=$raceid'));

    if (response.statusCode == 200) {
      return List<String>.from(jsonDecode(response.body));
    } else {
      return [];
    }
  }

  ///Fetches all the clubs ralative to a race
  Future<List<String>> fetchClubs(String raceid) async {
    final response =
        await http.get(Uri.parse('$apiUrl/list_clubs?race_id=$raceid'));

    if (response.statusCode == 200) {
      return List<String>.from(jsonDecode(response.body));
    } else {
      return [];
    }
  }

  ///Fetches the starting list ralative to a race
  Future<List<dynamic>> fetchStartingList(String raceid) async {
    final response =
        await http.get(Uri.parse('$apiUrl/get_start_time?race_id=$raceid'));

    if (response.statusCode == 200) {
      return List<dynamic>.from(jsonDecode(response.body));
    } else {
      return [];
    }
  }

  ///Fetches all the rankings ralative to a class
  Future<List<dynamic>> fetchRankings(
      String raceid, String displayedClass) async {
    isLoading = true;
    final response = await http.get(
      Uri.parse('$apiUrl/results?race_id=$raceid&className=$displayedClass'),
    );
    isLoading = false;

    if (response.statusCode == 200) {
      return List<dynamic>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load rankings.');
    }
  }

  ///Fetches all the rankings ralative to a club
  Future<List<dynamic>> fetchRankingsForClub(
      String raceid, String displayedClub) async {
    isLoading = true;
    final response = await http.get(Uri.parse(
        '$apiUrl/get_rank_by_club?race_id=$raceid&club=$displayedClub'));
    isLoading = false;

    if (response.statusCode == 200) {
      return List<dynamic>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load rankings for $displayedClub');
    }
  }
}

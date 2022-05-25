// ignore_for_file: library_private_types_in_public_api
import 'package:Orienteering/Screens/AllRaces.dart';
import 'package:Orienteering/Screens/FavoriteRaces.dart';
import 'package:Orienteering/Utilities/costum_icons_icons.dart';
import 'package:flutter/material.dart';
import './Utilities/custumTheming.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Orienteering',
      debugShowCheckedModeBanner: false,
      theme: orienteeringTheme,
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ///Contains a list of all the top-level pages
  List<Widget> pages = [
    const AllRaces(),
    const FavoriteRaces(),
  ];

  ///Current selected index
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  ///When an item is tapped in the bottomNavigationBar its index is selected
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.list), label: 'Available Races'),
          BottomNavigationBarItem(
              icon: Icon(CostumIcons.heart), label: 'Favorite Races'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

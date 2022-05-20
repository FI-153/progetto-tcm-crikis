import 'package:app_base_orienteering/Screens/AllRaces.dart';
import 'package:app_base_orienteering/Screens/FavoriteRaces.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Ori Live Results',
      home: MyApp(),
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
    AllRaces(),
    FavoriteRaces(),
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
              icon: Icon(Icons.star), label: 'Favorite Races'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

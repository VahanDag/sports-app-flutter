import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sports_app/views/home.dart';
import 'package:sports_app/views/news.dart';
import 'package:sports_app/views/statistics.dart';

class RouterPage extends StatefulWidget {
  const RouterPage({super.key});

  @override
  State<RouterPage> createState() => _RouterPageState();
}

class _RouterPageState extends State<RouterPage> {
  int _currentIndex = 0;

  static const List<Widget> _pages = [MatchesPage(), Statistics(), NewsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Fixture
          SalomonBottomBarItem(
            icon: const Icon(Icons.sports_basketball),
            title: const Text("Fixture"),
            selectedColor: Colors.blue,
          ),

          /// Statistics
          SalomonBottomBarItem(
            icon: const Icon(Icons.search_rounded),
            title: const Text("Statistics"),
            selectedColor: Colors.teal,
          ),

          /// News
          SalomonBottomBarItem(
            icon: const Icon(Icons.menu_book_sharp),
            title: const Text("News"),
            selectedColor: Colors.pink,
          ),
        ],
      ),
      body: _pages[_currentIndex],
    );
  }
}

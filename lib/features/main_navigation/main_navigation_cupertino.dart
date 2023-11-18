import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigationScreenCupertino extends StatefulWidget {
  MainNavigationScreenCupertino({super.key});

  @override
  State<MainNavigationScreenCupertino> createState() => _MainNavigationScreenCupertinoState();
}

class _MainNavigationScreenCupertinoState extends State<MainNavigationScreenCupertino> {
  int _selectedIndex = 0;

  final screens = [
    Center(
      child: Text('Home'),
    ),
    Center(
      child: Text('Search'),
    ),
    Center(
      child: Text('Home'),
    ),
    Center(
      child: Text('Search'),
    ),
    Center(
      child: Text('Search'),
    ),
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Search',
          ),
        ],
      ),
      tabBuilder: (context, index) => screens[index],
    );
  }
}

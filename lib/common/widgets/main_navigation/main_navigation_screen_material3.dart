import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigationScreenMaterial3 extends StatefulWidget {
  MainNavigationScreenMaterial3({super.key});

  @override
  State<MainNavigationScreenMaterial3> createState() => _MainNavigationScreenMaterial3State();
}

class _MainNavigationScreenMaterial3State extends State<MainNavigationScreenMaterial3> {
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
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onTap,
        destinations: [
          NavigationDestination( 
            icon: FaIcon(
              FontAwesomeIcons.house,
              color: Colors.amber,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: Colors.teal,
            ),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}

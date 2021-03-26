import 'package:flutter/material.dart';
import 'package:food_education_app/pages/home/home_screen.dart';

import 'package:ss_bottom_navbar/ss_bottom_navbar.dart';
import 'package:food_education_app/pages/Search/searchpage.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  SSBottomBarState _state;
  bool _isVisible = true;

  final items = [
    SSBottomNavItem(text: 'Home', iconData: Icons.home, iconSize: 20),
    SSBottomNavItem(text: 'Finder', iconData: Icons.search, iconSize: 20),
    SSBottomNavItem(
        text: 'Reward', iconData: Icons.monetization_on, iconSize: 20),
    SSBottomNavItem(text: 'Profile', iconData: Icons.person, iconSize: 20),
  ];

  @override
  void initState() {
    _state = SSBottomBarState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _state.selected,
        children: <Widget>[
          HomeScreen(),
          HomeScreen(),

        ],
      ),
      bottomNavigationBar: SSBottomNav(
        items: items,
        state: _state,
        color: Color(0xFF00A299),
        selectedColor: Colors.white,
        unselectedColor: Colors.grey[700],
        visible: _isVisible,
        bottomSheetWidget: _bottomSheet(),
        showBottomSheetAt: 1,
      ),
    );
  }

  Widget _bottomSheet() => Container(
        color: Colors.white,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Barcode Scanner'),
            ),
            ListTile(
              leading: Icon(Icons.title),
              title: Text('Text Input'),
              onTap: () => Navigator.push(//temp location for editing detail result page (figo)
                context,
                MaterialPageRoute(builder: (context)=> Searchpage())
              ),
            ),
          ],
        ),
      );
}

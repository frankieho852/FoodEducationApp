import 'package:flutter/material.dart';
import 'package:food_education_app/pages/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:ss_bottom_navbar/ss_bottom_navbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "FoodEdu App",
      theme: ThemeData(
        primaryColor: Color(0xFF00A299),
        //textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: 'home',
      routes: {
        'home': (context) => HomeScreen(),
      },
    );
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  SSBottomBarState _state;
  bool _isVisible = true;

  final _colors = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];
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
    return ChangeNotifierProvider(
      create: (_) => _state,
      builder: (context, child) {
        context.watch<SSBottomBarState>();
        return Scaffold(
          body: IndexedStack(
            index: _state.selected,
            children: _buildPages(),
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
      },
    );
  }

  Widget _page(Color color) => Container(color: color);

  List<Widget> _buildPages() => _colors.map((color) => _page(color)).toList();

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
            ),
          ],
        ),
      );
}

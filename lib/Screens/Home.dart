import 'package:Nirvana/Screens/Drawer.dart';
import 'package:Nirvana/Screens/GharScreen.dart';
import 'package:Nirvana/Screens/HomeScreen.dart';
import 'package:Nirvana/Screens/SearchScreen.dart';
import 'package:Nirvana/Screens/SettingScreen.dart';
import 'package:Nirvana/constants.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final int index;
  Home({this.index});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String firstName;
  
  @override
  void initState() {
    super.initState();
    initialise();
  }

  int _selectedIndex =0;
  void initialise() async {
    _selectedIndex = widget.index; 
  }
  
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black);
  List<Widget> _widgetOptions = [HomeScreen(), SearchScreen(), GharScreen() , SettingScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavigationDrawer(),
      body: Center(
        child:  _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.near_me),
            title: Text('Explore'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hail),
            title: Text('Ghar'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
        unselectedItemColor: grey,
        selectedItemColor: primaryColor,
        currentIndex: _selectedIndex,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        selectedIconTheme: IconThemeData(size: 40, color: primaryColor),
      ),
    );
  }
}
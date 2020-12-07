import 'package:Nirvana/Screens/LandingScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Nirvana/Screens/Home.dart';

void main() async {
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Nirvana()
    );
  }
}

class Nirvana extends StatefulWidget {
  @override
  _NirvanaState createState() => _NirvanaState();
}

class _NirvanaState extends State<Nirvana> {

  bool login = false;

  Future checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _login = (prefs.getBool('login') == null);
    setState(() {
      login = _login;
    });
  }

  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: login ? LandingScreen() : Home(index: 0),
    );
  }
}

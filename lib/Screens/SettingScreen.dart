import 'package:Nirvana/Screens/Drawer.dart';
import 'package:Nirvana/constants.dart';
import 'package:flutter/material.dart';
import 'package:Nirvana/Widget/SettingsDivider.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String firstName;
  
  @override
  void initState() {
    super.initState();
    initialise();
  }
  
  void initialise() async {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavigationDrawer(),
      body: SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                AppBar(
                  backgroundColor: primaryColor,
                ),
                ClipPath(
                  clipper: WaveClipperTwo(),
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    height: 120,
                    decoration: BoxDecoration(
                      color: primaryColor,
                    ),
                    child: ListTile(
                        leading: Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: IconButton(
                            icon: new Icon(
                              Icons.menu,
                              size: 24,
                              color: white,
                            ),
                            onPressed: () => _scaffoldKey.currentState.openDrawer(),
                          ),
                        ),
                        title: Text(
                          "Settings",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              color: white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.3),
                        ),
                        trailing: Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: IconButton(
                            icon: new Icon(
                              Icons.notifications,
                              size: 24,
                              color: white,
                            ),
                            onPressed: () => {},
                          ),
                        )
                      ),
                  ),
                ),
              ],
            ),
            SettingsDivider(dividerTitle: "PERSONAL"),
            Container(
                margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text("Name",
                            style: TextStyle(color: Colors.black, fontSize: 15)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text("Ajinkya Taranekar",
                            style: TextStyle(color: Colors.black, fontSize: 15)),
                      ),
                    )
                  ],
                )),
            Container(
                margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text("Phone Number",
                            style: TextStyle(color: Colors.black, fontSize: 15)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text("+91 8518076044",
                            style: TextStyle(color: Colors.black, fontSize: 15)),
                      ),
                    )
                  ],
                )),
            Padding(padding: EdgeInsets.all(8)),
            SettingsDivider(dividerTitle: "NOTIFICATIONS"),
            Container(
                margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text("Push Notifications",
                            style: TextStyle(color: Colors.black, fontSize: 15)),
                      ),
                    ),
                    Container(
                      child: Switch(value: true, onChanged: (bool value) {}),
                    )
                  ],
                )),
            SettingsDivider(dividerTitle: "OTHER"),
            Container(
              margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
              alignment: Alignment.topLeft,
              child: Text("Change Location",
                  style: TextStyle(color: Colors.black, fontSize: 15)),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
              alignment: Alignment.topLeft,
              child: Text("Log Out",
                  style: TextStyle(color: Colors.black, fontSize: 15)),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
              alignment: Alignment.topLeft,
              child: Text("Refer the APP",
                  style: TextStyle(color: Colors.black, fontSize: 15)),
            ),
            Padding(padding: EdgeInsets.all(8)),
            SettingsDivider(dividerTitle: "FEEDBACK"),
            Container(
              margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
              alignment: Alignment.topLeft,
              child: Text("Chat With Us",
                  style: TextStyle(color: Colors.black, fontSize: 15)),
            ),
          ],
        ),
      ),
    );
  }
}
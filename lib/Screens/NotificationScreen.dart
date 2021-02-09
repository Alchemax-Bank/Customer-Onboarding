import 'dart:io';

import 'package:Nirvana/Screens/Drawer.dart';
import 'package:Nirvana/Screens/PropertyDetailScreen.dart';
import 'package:Nirvana/Services/bookingService.dart';
import 'package:Nirvana/Services/propertyList.dart';
import 'package:Nirvana/Services/tenantProfile.dart';
import 'package:Nirvana/constants.dart';
import 'package:Nirvana/models/Booking.dart';
import 'package:Nirvana/models/Tenant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Nirvana/models/Property.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';


class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPreferences prefs;
  Tenant tenant;
  
  @override
  void initState() {
    super.initState();
    initialise();
  }
  
  void initialise() async {

  }


  var notification;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavigationDrawer(),
      body: Column(
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
                        "Notifications",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.3),
                      ),
                    ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 32, right:32, top: 16, bottom: 16),
            color: Colors.grey[100],
            child: Text("0 Results Found", style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold),),
          ), 

          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/notification.png"),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter),
              ),
              child: null
            
          )
        ],
      ),
    );
  }
  void _launchMapsUrl(String lat, String lon) async {
    // var latitude = origin['latitude'];
    // var longitude = origin['longitude'];
    
    final url = 'https://www.google.com/maps/Notification/?api=1&query=$lat,$lon';
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
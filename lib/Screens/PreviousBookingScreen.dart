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


class PreviousBookingScreen extends StatefulWidget {
  @override
  _PreviousBookingScreenState createState() => _PreviousBookingScreenState();
}

class _PreviousBookingScreenState extends State<PreviousBookingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPreferences prefs;
  List<Property> property;
  Tenant tenant;
  
  @override
  void initState() {
    super.initState();
    initialise();
  }
  
  void initialise() async {
    checkBooking();
  }


  List<Booking> booking;

  Future checkBooking() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var mobile = prefs.getString("mobile");
    Tenant tmp = await getTenantProfile(mobile);
    List<Booking> book = await getAllBooking(tmp.id);
    List<Property> prop = [];
    if (book != null){
        for (int i =0; i < book.length ; i++){
            await getProperty(book[i].property_id).then((value) {
              prop.add(value);
            });
        }
    }
      
    setState(() {
      tenant = tmp;
      booking = book;
      property = prop;
    });

  }

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
                        "Previous Bookings",
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
          SizedBox(
            height: 15,
          ),
          
          booking !=null ? Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 32, right:32, top: 16, bottom: 16),
            color: Colors.grey[100],
            child: Text(property.length.toString() + " Results Found", style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold),),
          ) : 
          SpinKitWave(
            color: primaryColor,
            size: 50.0,
          ),

          booking !=null ? Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              color: Colors.grey[100],
              child: ListView.separated(
                  itemBuilder: (context, index){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: 90,
                              height: 90,
                              child: GestureDetector(
                                child: ClipOval(
                                  child: Image.asset("assets/images/home.jpg", fit: BoxFit.cover,),
                                ),
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PropertyDetailScreen(propertyDetail: property[index])
                                  ));
                                },
                              )
                            ),

                            SizedBox(width: 20,),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(property[index].name, style: TextStyle(fontSize: 22, color: Colors.grey[800], fontWeight: FontWeight.bold),),
                                  Text(property[index].location, style: TextStyle(color: Colors.grey[500],), overflow: TextOverflow.ellipsis,),
                                  SizedBox(height: 8,),
                                  Text("₹ "+ property[index].price.toString(), style: TextStyle(fontSize: 18, color: primaryColor, fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),

                            IconButton(icon: Icon(Icons.navigation), onPressed: () { 
                              _launchMapsUrl(property[index].latitude, property[index].longitude);
                            },)
                          ],
                        ),

                        SizedBox(height: 12,),

                        Container(
                          margin: EdgeInsets.only(left: 32, right: 16),
                          child: Column(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(Icons.calendar_today, size: 12, color: Colors.grey[600],),
                                  SizedBox(width: 4,),
                                  Text("Check in: " + booking[index].check_in, style: TextStyle(color: Colors.grey[600]),)
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.calendar_today, size: 12, color: Colors.grey[600],),
                                  SizedBox(width: 4,),
                                  Text("Check out: " + booking[index].check_out, style: TextStyle(color: Colors.grey[600]),)
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 16,)
                      ],

                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: property.length
              ),
            ),
          ) : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/result.png"),
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
    
    final url = 'https://www.google.com/maps/PreviousBooking/?api=1&query=$lat,$lon';
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
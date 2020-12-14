import 'package:Nirvana/Screens/Drawer.dart';
import 'package:Nirvana/Screens/LocationPicker.dart';
import 'package:Nirvana/Screens/PropertyDetailScreen.dart';
import 'package:Nirvana/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Nirvana/Services/propertyList.dart';
import 'package:Nirvana/models/Property.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';


class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var startLocation = [];
  SharedPreferences prefs;
  List<Property> property;
  Map<String, dynamic> filter;

  @override
  void initState() {
    super.initState();
    startLocation.insert(0, "Where do you wanna live?");
    init();
  }

  init() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cnt', 0);
  }

  setLocation(BuildContext context) async {
    await prefs.setString('lat', startLocation[1].toString());
    await prefs.setString('lon', startLocation[2].toString());
    filter = {
      "origin": {
        "latitude": startLocation[1],
        "longitude": startLocation[2],
      },
      "distance": 10,
      "bhk": 2,
      "price": 10000,
      "type": null
    };
    print(filter);
    List<Property> tmp = await getFilteredProperties(filter);
    setState(() {
      property = tmp;
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
                        "Explore",
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
          
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
            ),
            child: GestureDetector(
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LocationPicker(header: "Enter Location"))).then((value) => setStart(value))
              },
              child: Container(
                width: 0.9 *  MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Center(
                  child: Text(startLocation[0].toString(),
                    style: TextStyle(
                      fontSize: 0.02 *  MediaQuery.of(context).size.height,
                      color: grey
                    )
                  ),
                )
              ),
            )
          ),

          SizedBox(
            height: 15,
          ),
          RaisedButton(
            onPressed: () => {
              if(startLocation.length == 3)
                setLocation(context)
              else
                showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Location not selected",
                      style: TextStyle(
                        color: primaryColor
                      ),
                    ),
                    content: Text("Please select your start and end location to continue"),
                    actions: [
                      FlatButton(
                        child: Text("OK",
                          style: TextStyle(
                            color: primaryColor
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                },
              )
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
            ),
            color: primaryColor,
            elevation: 5,
            child: Text(
              "Let's go!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 0.1 * MediaQuery.of(context).size.width, vertical: 0.01 * MediaQuery.of(context).size.height),
          ),

          SizedBox(
            height: 15,
          ),
          
          startLocation.length == 3 && property !=null ? Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 32, right:32, top: 16, bottom: 16),
            color: Colors.grey[100],
            child: Text(property.length.toString() + " Results Found", style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold),),
          ) : Container(),

          startLocation.length == 3 && property !=null ? Expanded(
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
                                  Text("Rs. "+ property[index].price.toString(), style: TextStyle(fontSize: 18, color: primaryColor, fontWeight: FontWeight.bold),),
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
                          child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(Icons.home, size: 12, color: Colors.grey[600],),
                                  SizedBox(width: 4,),
                                  Text(property[index].area_in_sqft.toString() + " \narea", style: TextStyle(color: Colors.grey[600]),)
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.king_bed, size: 12, color: Colors.grey[600],),
                                  SizedBox(width: 4,),
                                  Text(property[index].numberOfRooms.toString() + " \nBedrooms", style: TextStyle(color: Colors.grey[600]),)
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.airline_seat_legroom_reduced, size: 12, color: Colors.grey[600],),
                                  SizedBox(width: 4,),
                                  Text(property[index].bathrooms.toString().split(" ")[0] + "\nBathroom", style: TextStyle(color: Colors.grey[600]),)
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
          ) : SpinKitWave(
                color: primaryColor,
                size: 50.0,
              )
        ],
      ),
    );
  }
  setStart(var value) async {
    if(value.length > 0) {
      setState(() {
        startLocation = value;
      });
    }
  }
  void _launchMapsUrl(double lat, double lon) async {
    // var latitude = origin['latitude'];
    // var longitude = origin['longitude'];
    
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
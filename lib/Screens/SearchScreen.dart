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
  var location = [];
  SharedPreferences prefs;
  List<Property> property;
  Map<String, dynamic> filter;
  int distance;
  int bhk ;
  int rating ;
  int price ;
  String type ;
  String landmarks ;

  @override
  void initState() {
    super.initState();
    location.insert(0, "Where do you wanna live?");
    init();
  }

  init() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cnt', 0);
  }

  setLocation(BuildContext context) async {
    await prefs.setString('lat', location[1].toString());
    await prefs.setString('lon', location[2].toString());
    filter = {
      "origin": {
        "latitude": location[1],
        "longitude": location[2],
      },
      "distance": distance,
      "bhk": bhk,
      "price": price,
      "type": type,
      "rating": rating,
      "landmark": landmarks
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
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () => {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LocationPicker(header: "Enter Location"))).then((value) => setStart(value))
                  },
                  child: Container(
                    width: 0.8 *  MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    child: Center(
                      child: Text(location[0].toString(),
                        style: TextStyle(
                          fontSize: 0.02 *  MediaQuery.of(context).size.height,
                          color: grey
                        )
                      ),
                    )
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.filter_alt, color: primaryColor),
                  onPressed: () {
                    showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Add Filters",
                          style: TextStyle(
                            color: primaryColor
                          ),
                        ),
                        content: new Container(
                          width: 260.0,
                          height: 260.0,
                          decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: const Color(0xFFFFFF),
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(50.0)),
                          ),
                          child: new Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Distance: ', style: TextStyle(color: primaryColor,),),
                                  DropdownButton<int>(
                                    value: this.distance,
                                    icon: Icon(Icons.arrow_downward),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: TextStyle(
                                      color: grey
                                    ),
                                    onChanged: (int newValue) {
                                      setState(() {
                                        this.distance = newValue;
                                      });
                                    },
                                    items: <int>[5, 10, 20, 50]
                                      .map<DropdownMenuItem<int>>((int value) {
                                        return DropdownMenuItem<int>(
                                          value: value,
                                          child: Text(value == null ? "Select distance" : value.toString() + ' KM'),
                                        );
                                      })
                                      .toList(),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('BHK: ', style: TextStyle(color: primaryColor,),),
                                  DropdownButton<int>(
                                    value: this.bhk,
                                    icon: Icon(Icons.arrow_downward),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: TextStyle(
                                      color: grey
                                    ),
                                    onChanged: (int newValue) {
                                      setState(() {
                                        this.bhk = newValue;
                                      });
                                    },
                                    items: <int>[null, 1, 2, 3, 4, 5]
                                      .map<DropdownMenuItem<int>>((int value) {
                                        return DropdownMenuItem<int>(
                                          value: value,
                                          child: Text(value == null ? "Select BHK" : value.toString() + 'BHK'),
                                        );
                                      })
                                      .toList(),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Rating: ', style: TextStyle(color: primaryColor,),),
                                  DropdownButton<int>(
                                    value: this.rating,
                                    icon: Icon(Icons.arrow_downward),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: TextStyle(
                                      color: grey
                                    ),
                                    onChanged: (int newValue) {
                                      setState(() {
                                        this.rating = newValue;
                                      });
                                    },
                                    items: <int>[null, 1, 2, 3, 4, 5]
                                      .map<DropdownMenuItem<int>>((int value) {
                                        return DropdownMenuItem<int>(
                                          value: value,
                                          child: Text(value == null ? "Select Rating" : value.toString() + ' ⭐'),
                                        );
                                      })
                                      .toList(),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Price: ', style: TextStyle(color: primaryColor,),),
                                  DropdownButton<int>(
                                    value: this.price,
                                    icon: Icon(Icons.arrow_downward),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: TextStyle(
                                      color: grey
                                    ),
                                    onChanged: (int newValue) {
                                      setState(() {
                                        this.price = newValue;
                                      });
                                    },
                                    items: <int>[null, 1000, 5000, 10000, 50000]
                                      .map<DropdownMenuItem<int>>((int value) {
                                        return DropdownMenuItem<int>(
                                          value: value,
                                          child: Text(value == null ? "Select a price" : '₹ ' + value.toString()),
                                        );
                                      })
                                      .toList(),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Type: ', style: TextStyle(color: primaryColor,),),
                                  DropdownButton<String>(
                                    value: this.type,
                                    icon: Icon(Icons.arrow_downward),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: TextStyle(
                                      color: grey
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        this.type = newValue;
                                      });
                                    },
                                    items: <String>[null, 'Apartment', 'Independent House', 'Independent Floor', 'Studio Apartment', 'Villa']
                                      .map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value == null ? "Select a Type" : value),
                                        );
                                      })
                                      .toList(),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Landmarks: ', style: TextStyle(color: primaryColor,),),
                                  DropdownButton<String>(
                                    value: this.landmarks,
                                    icon: Icon(Icons.arrow_downward),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: TextStyle(
                                      color: grey
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        this.landmarks = newValue;
                                      });
                                    },
                                    items: <String>[null, 'College', 'School', 'Industry', 'Office', 'Airport', 'Bus Depot', 'Railway', 'Metro', 'City Center']
                                      .map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value == null ? "Select a Landmark" : value),
                                        );
                                      })
                                      .toList(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
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
                  );
                  },
                )
              ],
            ),
          ),

          SizedBox(
            height: 15,
          ),
          RaisedButton(
            onPressed: () => {
              if(location.length == 3)
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
                    content: Text("Please select your location to continue"),
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
          
          location.length == 3 && property !=null ? Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 32, right:32, top: 16, bottom: 16),
            color: Colors.grey[100],
            child: Text(property.length.toString() + " Results Found", style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold),),
          ) : 
          SpinKitWave(
            color: primaryColor,
            size: 50.0,
          ),

          location.length == 3 && property !=null ? Expanded(
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
  setStart(var value) async {
    if(value.length > 0) {
      setState(() {
        location = value;
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
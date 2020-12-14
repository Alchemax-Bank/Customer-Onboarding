import 'package:Nirvana/Screens/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:Nirvana/constants.dart';
import 'package:Nirvana/models/Property.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingScreen extends StatefulWidget {
  final Property propertyDetail;
  BookingScreen({this.propertyDetail});
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  
  @override
  void initState() {
    super.initState();
    initialise();
  }
  
  void initialise() async {
    
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavigationDrawer(),
      body: SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
        child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              AppBar(
                backgroundColor: primaryColor,
              ),
              ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 180,
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
                          "Booking",
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
          SizedBox(height: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 32, right: 32, top: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: <Widget>[
                        Container(
                          width: media.size.width-64-48,
                          child: Text(widget.propertyDetail.name,
                            style: TextStyle(fontSize: 18, color: Colors.grey[800], fontWeight: FontWeight.bold),
                          ),
                        ),

                        SizedBox(height: 8,),
                        Text(widget.propertyDetail.location,
                          style: TextStyle(color: Colors.grey[500],), overflow: TextOverflow.ellipsis),
                        SizedBox(height: 16,),

                        Text(widget.propertyDetail.price.toString() + " Rs/ month",
                            style: TextStyle(fontSize: 18,color: primaryColor, fontWeight: FontWeight.bold), ),
                        SizedBox(height: 8,),

                        Text(widget.propertyDetail.deposit == "No Deposit" ? "No Deposit" :"Deposit: Rs." + widget.propertyDetail.deposit ,
                            style: TextStyle(fontSize: 14, color: primaryColor), ),

                      ],
                    ),

                    IconButton(
                      icon: Icon(Icons.navigation, color: primaryColor,), onPressed: () {  
                          _launchMapsUrl(widget.propertyDetail.latitude,widget.propertyDetail.longitude);
                      },
                    )
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: 32, right: 32, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.people, size: 12, color: Colors.grey[600],),
                        SizedBox(width: 4,),
                        Text("5 people", style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),)
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.local_offer, size: 12, color: Colors.grey[600],),
                        SizedBox(width: 4,),
                        Text("2 Beds", style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),)
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.airline_seat_legroom_reduced, size: 12, color: Colors.grey[600],),
                        SizedBox(width: 4,),
                        Text("2 Bathrooms", style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 8,
              ),

              Divider(),

              Container(
                margin: EdgeInsets.only(left: 32, right: 32),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      child: ClipRRect(
                        child: Image.asset("assets/images/avatar.png", fit: BoxFit.contain,),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),

                    SizedBox(width: 16,),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Ajinkya Taranekar", style: TextStyle(color: Colors.grey[800], fontSize : 18, fontWeight: FontWeight.w600),),
                          Text("Owner", style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w400),)
                        ],
                      ),
                    ),

                    FlatButton(
                      child : Text("Chat", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),),
                      onPressed: (){},
                      color: primaryColor,
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 8,
              ),

              Divider(),

              Container(
                margin: EdgeInsets.only(left: 32, right: 32),
                child: FlatButton(
                  child : Text("Book", style: TextStyle(color: Colors.grey[100], fontSize: 16, fontWeight: FontWeight.w600), ),
                  onPressed: (){
                    //booking algo here
                  },
                  color: primaryColor,
                )
              )
            ],
          ),
          ],
        ),
      ),
    );
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
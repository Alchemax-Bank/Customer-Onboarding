import 'package:Nirvana/Screens/Drawer.dart';
import 'package:Nirvana/Services/bookingService.dart';
import 'package:Nirvana/Services/propertyList.dart';
import 'package:Nirvana/Services/tenantProfile.dart';
import 'package:Nirvana/models/Tenant.dart';
import 'package:Nirvana/models/Booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:Nirvana/Widget/Cards.dart';
import 'package:Nirvana/constants.dart';
import 'package:Nirvana/models/Property.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:Nirvana/Screens/NotificationScreen.dart';
import 'package:page_transition/page_transition.dart';

class GharScreen extends StatefulWidget {
  @override
  _GharScreenState createState() => _GharScreenState();
}

class _GharScreenState extends State<GharScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Tenant tenant;
  Property property;
  
  @override
  void initState() {
    super.initState();
    initialise();
  }
  
  void initialise() async {
    checkBooking();
  }

  Future checkBooking() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var mobile = prefs.getString("mobile");
    Tenant tmp = await getTenantProfile(mobile);
    Property prop;
    if (tmp.property_id != null)
      prop = await getProperty(tmp.property_id);

    setState(() {
      tenant = tmp;
      property = prop;
    });

  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavigationDrawer(),
      body: tenant != null ? SingleChildScrollView(
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
                          "Mera Ghar",
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
                            onPressed: () => {
                              Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeftWithFade,
                                  child: NotificationScreen()))
                            },
                          ),
                        )
                      ),
                ),
              ),
              property == null ? Container() : Container(
                height: 260,
                color: Colors.transparent,
                margin: EdgeInsets.only(top: 90),
                child: Swiper(
                  loop: false,
                  itemWidth: 360,
                  itemHeight: 420,
                  index: 1,
                  itemCount: propertyDetails.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PropertyDetailCard(
                        image: propertyDetails[index].image,
                        title: propertyDetails[index].title,
                        description: propertyDetails[index].description);
                  },
                  viewportFraction: 0.75,
                  pagination: new SwiperPagination(
                      alignment: Alignment(0, 1.4),
                      builder: DotSwiperPaginationBuilder(color: grey)),
                  scale: 0.8,
                  layout: SwiperLayout.DEFAULT,
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          property == null ? Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/booking.png"),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter),
            ),
            child: Stack(children: <Widget>[
              Positioned(
                  bottom: -5.0,
                  left: MediaQuery.of(context).size.width*0.35,
                  child: Text("Haven't book yet? \nExplore Nivana!",
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600))),
            ])
            ) : Column(
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
                          child: Text(property.name,
                            style: TextStyle(fontSize: 18, color: Colors.grey[800], fontWeight: FontWeight.bold),
                          ),
                        ),

                        SizedBox(height: 8,),
                        Text(property.location,
                          style: TextStyle(color: Colors.grey[500],), overflow: TextOverflow.ellipsis),
                        SizedBox(height: 16,),

                        Text("₹ "+property.price.toString() + " / month",
                            style: TextStyle(fontSize: 18,color: primaryColor, fontWeight: FontWeight.bold), ),
                        SizedBox(height: 8,),

                        Text(property.deposit == "No Deposit" ? "No Deposit" :"Deposit: ₹" + property.deposit ,
                            style: TextStyle(fontSize: 14, color: primaryColor), ),

                      ],
                    ),

                    IconButton(
                      icon: Icon(Icons.navigation, color: primaryColor,), onPressed: () {  
                          _launchMapsUrl(property.latitude,property.longitude);
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
                        Icon(Icons.house, size: 12, color: Colors.grey[600],),
                        SizedBox(width: 4,),
                        Text(property.area_in_sqft.toString() + ' area' , style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),)
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.king_bed, size: 12, color: Colors.grey[600],),
                        SizedBox(width: 4,),
                        Text(property.numberOfRooms.toString() + " Beds", style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),)
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.airline_seat_legroom_reduced, size: 12, color: Colors.grey[600],),
                        SizedBox(width: 4,),
                        Text(property.bathrooms, style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),)
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Description", style: TextStyle(color: Colors.grey[800], fontSize : 18, fontWeight: FontWeight.w600),),
                          Text(property.description != null ? property.description : "No Description" , style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w400),),
                        ],
                      ),
                    ),
                  ],
                ),
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
                          Text(property.landlord_name, style: TextStyle(color: Colors.grey[800], fontSize : 18, fontWeight: FontWeight.w600),),
                          Text("AGENT", style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w400),),
                          Text(property.landlord_rating.toString() + " ⭐", style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w400),)
                        ],
                      ),
                    ),

                    FlatButton(
                      child : Text("Call", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),),
                      onPressed: (){
                        launch("tel:8518076044");
                      },
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Features", style: TextStyle(color: Colors.grey[800], fontSize: 18, fontWeight: FontWeight.w600), ),
                    SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.wifi, color:  primaryColor,),
                            SizedBox(width: 4,),
                            Text("Wifi", style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.local_offer, color:  primaryColor,),
                            SizedBox(width: 4,),
                            Text("Bed", style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.videogame_asset, color:  primaryColor,),
                            SizedBox(width: 4,),
                            Text("T. Tennis", style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),)
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.view_agenda, color:  primaryColor,),
                            SizedBox(width: 4,),
                            Text("Balcony", style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.upgrade, color:  primaryColor,),
                            SizedBox(width: 4,),
                            Text("Lift", style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.electrical_services, color:  primaryColor,),
                            SizedBox(width: 4,),
                            Text("Electricity \n Backup", style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),)
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          ],
        ),
      ) : SpinKitDoubleBounce(
            color: primaryColor,
            size: 50.0,
          ),
    );
  }
  void _launchMapsUrl(String lat, String lon) async {
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
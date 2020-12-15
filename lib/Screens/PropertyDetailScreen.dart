import 'package:Nirvana/Screens/Drawer.dart';
import 'package:Nirvana/Screens/Home.dart';
import 'package:Nirvana/Screens/BookingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:Nirvana/Widget/Cards.dart';
import 'package:Nirvana/constants.dart';
import 'package:Nirvana/models/Property.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

class PropertyDetailScreen extends StatefulWidget {
  final Property propertyDetail;
  PropertyDetailScreen({this.propertyDetail});
  @override
  _PropertyDetailScreenState createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
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
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.shopping_bag,
          size: 24,
          color: white,
        ),
        onPressed: () => { 
          Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.leftToRightWithFade,
              child: BookingScreen(propertyDetail: widget.propertyDetail)))
        },
      ),
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
                              Icons.navigate_before,
                              size: 24,
                              color: white,
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  type: PageTransitionType.leftToRightWithFade,
                                  child: Home(index:0)));
                            },
                          ),
                        ),
                        title: Text(
                          "Property",
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
              Container(
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

                        Text("₹ "+widget.propertyDetail.price.toString() + " / month",
                            style: TextStyle(fontSize: 18,color: primaryColor, fontWeight: FontWeight.bold), ),
                        SizedBox(height: 8,),

                        Text(widget.propertyDetail.deposit == "No Deposit" ? "No Deposit" :"Deposit: ₹" + widget.propertyDetail.deposit ,
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
                        Icon(Icons.house, size: 12, color: Colors.grey[600],),
                        SizedBox(width: 4,),
                        Text(widget.propertyDetail.area_in_sqft.toString() + ' area' , style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),)
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.king_bed, size: 12, color: Colors.grey[600],),
                        SizedBox(width: 4,),
                        Text(widget.propertyDetail.numberOfRooms.toString() + " Beds", style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),)
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.airline_seat_legroom_reduced, size: 12, color: Colors.grey[600],),
                        SizedBox(width: 4,),
                        Text(widget.propertyDetail.bathrooms, style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),)
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
                          Text(widget.propertyDetail.description != null ? widget.propertyDetail.description : "No Description" , style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w400),),
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
                          Text(widget.propertyDetail.landlord_name, style: TextStyle(color: Colors.grey[800], fontSize : 18, fontWeight: FontWeight.w600),),
                          Text(widget.propertyDetail.landlord_type, style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w400),),
                          Text(widget.propertyDetail.landlord_rating.toString() + " ⭐", style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w400),)
                        ],
                      ),
                    ),

                    FlatButton(
                      child : Text("Call", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),),
                      onPressed: (){
                        launch("tel://8518076044");
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
                            Icon(Icons.wifi, color:  primaryColor,),
                            SizedBox(width: 4,),
                            Text("Balcony", style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.local_offer, color:  primaryColor,),
                            SizedBox(width: 4,),
                            Text("Lift", style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.videogame_asset, color:  primaryColor,),
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
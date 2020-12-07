import 'package:Nirvana/Screens/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:Nirvana/Widget/Cards.dart';
import 'package:Nirvana/constants.dart';
import 'package:Nirvana/models/Property.dart';

class GharScreen extends StatefulWidget {
  @override
  _GharScreenState createState() => _GharScreenState();
}

class _GharScreenState extends State<GharScreen> {
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
                            onPressed: () => {},
                          ),
                        )
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
                          child: Text("Abc Tower, 3 Bed Rooms, Luxury Apartement",
                            style: TextStyle(fontSize: 18, color: Colors.grey[800], fontWeight: FontWeight.bold),
                          ),
                        ),

                        SizedBox(height: 8,),
                        Text("Shalimar Township, \nIndore - 452010",
                          style: TextStyle(color: Colors.grey[500],), overflow: TextOverflow.ellipsis),
                        SizedBox(height: 16,),

                        Text("3000 Rs /day",
                            style: TextStyle(fontSize: 18,color: primaryColor, fontWeight: FontWeight.bold), ),

                      ],
                    ),

                    IconButton(
                      icon: Icon(Icons.navigation), onPressed: () {  },
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
}
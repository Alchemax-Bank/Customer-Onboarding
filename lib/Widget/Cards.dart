import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:page_transition/page_transition.dart';
import 'package:Nirvana/models/Property.dart';
import 'package:Nirvana/constants.dart';
import 'package:Nirvana/Screens/PropertyDetailScreen.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class PropertyIntroCard extends StatelessWidget {
  final Property property;
  PropertyIntroCard({this.property});
  Widget leftPart(BuildContext context) {
    return Container(
      width: 190,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      // color: Colors.green,
      height: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            this.property.name,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          Text(
            this.property.description != "None"  ? this.property.description.toString().substring(0,20) + ' ...' : "No Description",
            style: TextStyle(color: grey, height: 1.5, fontSize: 9),
          ),
          Text(
            this.property.location,
            style: TextStyle(color: grey, height: 0.9, fontSize: 8),
          ),
        ],
      ),
    );
  }

  Widget rightPart(BuildContext context) {
    return Container(
      width: 60,
      // padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      height: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "View",
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: white),
          ),
          Text(
            "More",
            style: TextStyle(
                color: white,
                height: 1.2,
                fontWeight: FontWeight.bold,
                fontSize: 12),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.red[50],
                offset: const Offset(2, 6),
                blurRadius: 10)
          ]),
      child: Row(
        children: <Widget>[leftPart(context), rightPart(context)],
      ),
    );
  }
}

class PropertyCard extends StatelessWidget {
  final Property property;
  PropertyCard({this.property});
  
  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy/MM/dd');
    final String date = formatter.format(now);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: PropertyDetailScreen(propertyDetail: property)));
      },
      child: Stack(
        children: <Widget>[
          Container(
            height: 260,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: white,
              image: new DecorationImage(
                image: new ExactAssetImage("assets/images/home.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: new BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
              child: new Container(
                decoration:
                    new BoxDecoration(color: Colors.white.withOpacity(0)),
              ),
            ),
          ),
          Container(
            height: 260,
            // width: double.infinity,
            decoration: BoxDecoration(color: Color.fromRGBO(33, 33, 33, 0.1)),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    decoration: BoxDecoration(color: Color(0xff00D171)),
                    height: 30,
                    width: 90,
                    child: Center(
                      child: Text(
                        "PREMIUM",
                        style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.9,
                            fontSize: 13),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      decoration: new BoxDecoration(
                        border: Border.all(color: white, width: 0.5),
                        borderRadius: new BorderRadius.circular(10.0),
                        color: Colors.transparent,
                      ),
                      height: 30,
                      width: 105,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: white,
                          ),
                          Text(
                            date,
                            style: TextStyle(fontSize: 10, color: white),
                          )
                        ],
                      )),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: PropertyIntroCard(property: property),
                ),
                Positioned(
                  bottom: 80,
                  left: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    decoration: new BoxDecoration(
                      border: Border.all(color: primaryColor, width: 0),
                      borderRadius: new BorderRadius.circular(10.0),
                      color: primaryColor,
                    ),
                    height: 30,
                    width: 85,
                    child: Center(
                      child: Text(
                        "VACANT",
                        style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PropertyCard1 extends StatelessWidget {
  final Property property;
  final Map<String,double> origin;
  PropertyCard1({this.property, this.origin});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: const Offset(2, 6),
                blurRadius: 10)
          ]),
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    this.property.name,
                    style: prefix0.TextStyle(
                        fontSize: 18,
                        color: Color(0xFF465C61),
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.navigation, color:  primaryColor,),
                    onPressed: () {
                      _launchMapsUrl(this.property.latitude, this.property.longitude);
                    },
                    ),
                ],
              ),
              Text(
                this.property.description != "None"  ? 
                  this.property.description.substring(0,40) + ' ...' :
                  "No Description",
                style: prefix0.TextStyle(
                  fontSize: 12,
                  color: Color(0xFF94979C),
                  height: 1.8,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                this.property.location,
                style: prefix0.TextStyle(
                  fontSize: 10,
                  height: 1,
                  color: Color(0xFF94979C),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Icon(Icons.money, color:  primaryColor,),
                      SizedBox(width: 4,),
                      Text("₹ " + this.property.price.toString(), style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),)
                    ],
                  ),
                  SizedBox(width: 17,),
                  Column(
                    children: <Widget>[
                      Icon(Icons.king_bed, color:  primaryColor,),
                      SizedBox(width: 4,),
                      Text(this.property.numberOfRooms.toString() + ' bed', style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),)
                    ],
                  ),
                  SizedBox(width: 17,),
                  Column(
                    children: <Widget>[
                      Icon(Icons.bathtub, color:  primaryColor,),
                      SizedBox(width: 4,),
                      Text(this.property.bathrooms.toString(), style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),)
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.75 - 285,),
                  ClipOval(
                    child: Material(
                      color: Colors.blue, // button color
                      child: InkWell(
                        child: SizedBox(width: 56, height: 56, child: Icon(Icons.navigate_next, color: Colors.white,)),
                        onTap: () {
                          Navigator.pushReplacement(
                          context,
                          PageTransition(
                              type: PageTransitionType.leftToRightWithFade,
                              child: PropertyDetailScreen(propertyDetail: property,
                              )));
                        },
                      ),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
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

class PropertyDetailCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const PropertyDetailCard({Key key, this.image, this.title, this.description})
      : super(key: key);
  Widget PropertyDetailIntroCard() {
    return Container(
      height: 80,
      width: 200,
      padding: EdgeInsets.only(top: 5, left: 5, right: 2),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                offset: const Offset(2, 6),
                blurRadius: 10)
          ]),
      child: Column(
        children: <Widget>[
          Text(title,
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          Padding(
              padding: EdgeInsets.only(left: 5, top: 5),
              child: Text(description,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w300)))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 260,
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: white,
            image: new DecorationImage(
              image: new ExactAssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
          child: new BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
            child: new Container(
              decoration: new BoxDecoration(color: Colors.white.withOpacity(0)),
            ),
          ),
        ),
        Container(
          height: 260,
          // width: double.infinity,
          decoration: BoxDecoration(color: Color.fromRGBO(33, 33, 33, 0.1)),
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 30,
                right: 0,
                child: PropertyDetailIntroCard(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
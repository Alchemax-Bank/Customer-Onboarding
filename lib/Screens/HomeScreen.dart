import 'package:Nirvana/Widget/Cards.dart';
import 'package:Nirvana/constants.dart';
import 'package:Nirvana/Screens/Drawer.dart';
import 'package:Nirvana/Screens/NotificationScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as Coding;
import 'package:Nirvana/Services/propertyList.dart';
import 'package:Nirvana/models/Property.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Location location = new Location();
  List<Coding.Placemark> placemarks;
  String address;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  List<Property> property;
  List<Property> premiumProperty;
  Map<String, double> origin;

  @override
  void initState() {
    super.initState();
    currentLoc();
  }
  
  void popularProperties() async {
    List<Property> tmp = await getPopularProperties(origin);
    setState(() {
      property = tmp;
    });
  }
  
  void premiumProperties() async {
    List<Property> tmp = await getPremiumProperties(origin);
    setState(() {
      premiumProperty = tmp;
    });
  }
  currentLoc() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    Map<String, double> temp = {
      'latitude' : _locationData.latitude,
      'longitude' : _locationData.longitude
    };
    placemarks = await Coding.placemarkFromCoordinates(_locationData.latitude, _locationData.longitude);
    setState(() {
      origin = temp;
      address = placemarks[0].name + ', ' +placemarks[0].subLocality + ', ' +placemarks[0].locality;
    });
    popularProperties();
    premiumProperties();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavigationDrawer(),
      body: address != null ? SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
        child: Stack(
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
                      "Nirvana",
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
                    )),
              ),
            ),
            Container(
              height: 260,
              color: Colors.transparent,
              margin: EdgeInsets.only(top: 90),
              child: premiumProperty != null ? Swiper(
                itemWidth: 340,
                itemHeight: 400,
                itemBuilder: (BuildContext context, int index) {
                  return PropertyCard(property: premiumProperty[index],);
                },
                itemCount: premiumProperty.length,
                viewportFraction: 0.75,
                pagination: new SwiperPagination(
                    alignment: Alignment(0, 1.4),
                    builder: DotSwiperPaginationBuilder(color: grey)),
                scale: 0.8,
                layout: SwiperLayout.DEFAULT,
              ) : SpinKitWave(
                color: primaryColor,
                size: 50.0,
              )
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.only(top: 400),
              height: 400,
              child: Column(
                children: <Widget>[
                  Divider(
                    height: 8,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Most Popular \nNear",
                        style: TextStyle(
                            fontSize: 17,
                            color: primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.location_on_outlined,
                        color: primaryColor,
                      ),
                      Text(
                        this.address,
                        style: TextStyle(
                            fontSize: 12,
                            color: primaryColor),
                      )
                    ],
                  ),
                  property != null ? Container(
                      height: 330,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: property.length,
                        itemBuilder: (context, i) {
                          return PropertyCard1(property: property[i]);
                        },
                      )) : Container(
                        height: 300,
                        child: SpinKitWave(
                          color: primaryColor,
                          size: 30)
                        ),
                ],
              ),
            )
          ],
        ),
      ) : SpinKitDoubleBounce(
            color: primaryColor,
            size: 50.0,
          ),
    );
  }
}
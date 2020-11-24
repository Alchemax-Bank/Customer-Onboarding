import 'package:Nirvana/Widget/Cards.dart';
import 'package:Nirvana/constants.dart';
import 'package:Nirvana/Screens/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String firstName;
  
  @override
  void initState() {
    super.initState();
    initialise();
  }
  
  void initialise() async {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavigationDrawer(),
      body: SingleChildScrollView(
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
                          Icons.shopping_basket,
                          size: 24,
                          color: white,
                        ),
                        onPressed: () => {},
                      ),
                    )),
              ),
            ),
            Container(
              height: 260,
              color: Colors.transparent,
              margin: EdgeInsets.only(top: 90),
              child: Swiper(
                itemWidth: 340,
                itemHeight: 400,
                itemBuilder: (BuildContext context, int index) {
                  return PropertyCard();
                },
                itemCount: 10,
                viewportFraction: 0.75,
                pagination: new SwiperPagination(
                    alignment: Alignment(0, 1.4),
                    builder: DotSwiperPaginationBuilder(color: grey)),
                scale: 0.8,
                layout: SwiperLayout.DEFAULT,
              ),
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
                        "Most Popular",
                        style: TextStyle(
                            height: 2,
                            fontSize: 17,
                            color: primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Text("View more",
                          style: TextStyle(
                              height: 2,
                              fontSize: 15,
                              color: primaryColor,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  Container(
                      height: 330,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: 10,
                        itemBuilder: (context, i) {
                          return PropertyCard1();
                        },
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
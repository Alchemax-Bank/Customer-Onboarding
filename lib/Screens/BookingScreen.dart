import 'package:Nirvana/Screens/Drawer.dart';
import 'package:Nirvana/Screens/Home.dart';
import 'package:Nirvana/Services/bookingService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:Nirvana/constants.dart';
import 'package:Nirvana/models/Property.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  DateTime check_in = DateTime.now();
  DateTime check_out = DateTime.now();

  Future<void> _selectCheckInDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: check_in,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101,8));
    if (picked != null && picked != check_in)
      setState(() {
        check_in = picked;
      });
  }
  Future<void> _selectCheckOutDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: check_in,
        firstDate: check_in,
        lastDate: DateTime(2101,8));
    if (picked != null && picked != check_out)
      setState(() {
        check_out = picked;
      });
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
                              Icons.navigate_before,
                              size: 24,
                              color: white,
                            ),
                            onPressed: () {
                              Navigator.pop(
                              context);
                            },
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
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/booking_page.png"),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter),
              ),
              child: null
            ),
          ),
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
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                      FlatButton( 
                        color: primaryColor,
                        child: Row(
                          children: <Widget>[
                              Text("Check in: \n${check_in.toLocal().toString().split(" ")[0]}", style: TextStyle(color: Colors.white),),
                              Icon(Icons.calendar_today, color: Colors.white)
                          ],
                        ),
                        onPressed: () => _selectCheckInDate(context),
                      ),
                      FlatButton( 
                        color: primaryColor,
                        child: Row(
                          children: <Widget>[
                              Text("Check out: \n${check_out.toLocal().toString().split(" ")[0]}", style: TextStyle(color: Colors.white),),
                              Icon(Icons.calendar_today, color: Colors.white)
                          ],
                        ),
                        onPressed: () => _selectCheckOutDate(context),
                      ),
                  ],
              ),
              Container(
                margin: EdgeInsets.only(left: 32, right: 32),
                child: FlatButton(
                  child : Text("Book", style: TextStyle(color: Colors.grey[100], fontSize: 16, fontWeight: FontWeight.w600), ),
                  onPressed: () async {
                    //booking algo here
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    var tenant_id = prefs.getInt("tenant_id");
                    var info = {
                      "property_id" : widget.propertyDetail.index,
                      "tenant_id": tenant_id,
                      "check_in": check_in.toLocal().toString().split(' ')[0],
                      "check_out": check_out.toLocal().toString().split(' ')[0],
                    };
                    var book = await bookAProperty(info);

                    if (book!= null){
                      await prefs.setBool("booking", true);
                      print(book);
                      Fluttertoast.showToast(
                          msg: "Property Booked",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM, 
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey[200],
                          textColor: primaryColor,
                          fontSize: 12.0
                      );
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            child: Home(index: 0)));
                    }
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
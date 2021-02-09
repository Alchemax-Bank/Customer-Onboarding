import 'package:Nirvana/Screens/Drawer.dart';
import 'package:Nirvana/Screens/Home.dart';
import 'package:Nirvana/Services/bookingService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:Nirvana/constants.dart';
import 'package:Nirvana/models/Property.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
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
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();

  bool booking = false;
  @override
  void initState() {
    super.initState();
    initialise();
  }
  
  void initialise() async {
    
  }

  DateTime check_in = DateTime.now();
  DateTime check_out = DateTime.now().add(Duration(days: 30));

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
        initialDate: check_in.add(Duration(days: 30)),
        firstDate: check_in.add(Duration(days: 30)),
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
                              Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    type: PageTransitionType.leftToRightWithFade,
                                    child: Home(index: 0)));
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

                        Text("₹ " + widget.propertyDetail.price.toString() + " / month",
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

              SizedBox(
                height: 20,
              ),

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                      FlatButton( 
                        textColor: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: primaryColor)
                          ),
                        child: Row(
                          children: <Widget>[
                              Text("Check in: \n${check_in.toLocal().toString().split(" ")[0]}", style: TextStyle(color: primaryColor),),
                              Icon(Icons.calendar_today, color: primaryColor)
                          ],
                        ),
                        onPressed: () => _selectCheckInDate(context),
                      ),
                      FlatButton( 
                        textColor: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: primaryColor)
                          ),
                        child: Row(
                          children: <Widget>[
                              Text("Check out: \n${check_out.toLocal().toString().split(" ")[0]}", style: TextStyle(color: primaryColor),),
                              Icon(Icons.calendar_today, color: primaryColor)
                          ],
                        ),
                        onPressed: () => _selectCheckOutDate(context),
                      ),
                  ],
              ),
              
              SizedBox(
                height: 20,
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(left: 32, right: 32),
                  child: RoundedLoadingButton(
                    controller: _btnController, 
                    child : RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Book Now!",
                            style: TextStyle(
                                color: white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400)),
                      ]),
                    ),
                    onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        var tenant_id = prefs.getInt("tenant_id");
                        var info = {
                          "propertyId" : widget.propertyDetail.index,
                          "tenantId": tenant_id,
                          "checkIn": check_in.toLocal().toString().split(' ')[0],
                          "checkOut": check_out.toLocal().toString().split(' ')[0],
                        };
                        print(info);
                        var book = await bookAProperty(info);
                        print(book);
                        if (book){
                          await prefs.setBool("booking", true);
                          print(book);
                          _btnController.success();
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
                    color: Colors.redAccent,
                  )
                )
              ),
            ],
          ),
          ],
        ),
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
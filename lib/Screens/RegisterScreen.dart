import 'dart:convert';

import 'package:Nirvana/Screens/OTPScreen.dart';
import 'package:Nirvana/Services/tenantProfile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:page_transition/page_transition.dart';
import 'package:Nirvana/constants.dart';
import 'package:Nirvana/Screens/LoginScreen.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String firstName;
  String lastName;
  String mobileNo;
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: null,
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Stack(
            children: <Widget>[
              AnimatedContainer(
                height: MediaQuery.of(context).size.height,
                duration: Duration(milliseconds: 5),
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.48,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/register.png"),
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter),
                        ),
                        child: null
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                      child: Text(
                        "New Here?",
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 15, bottom: 5),
                              child: Text(
                                "First Name",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8, right: 8, bottom: 15),
                              child: Container(
                                  width: MediaQuery.of(context).size.width * 0.42,
                                  child:  TextFormField(
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(80),
                                      borderSide:
                                          const BorderSide(color: Colors.transparent, width: 0.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(80),
                                      borderSide:
                                          const BorderSide(color: Colors.transparent, width: 0.0),
                                    ),
                                    // disabledBorder: new InputBorder(borderSide: BorderSide.none),
                                    hintStyle: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                                    filled: true,
                                    fillColor: darkGrey,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 17, vertical: 12),
                                    hintText: "Enter your first name",
                                  ),
                                  onChanged: (value) async{
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    await prefs.setString('firstName', value);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 15, bottom: 5),
                              child: Text(
                                "Last Name",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8, right: 8, bottom: 15),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.42,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(80),
                                      borderSide:
                                          const BorderSide(color: Colors.transparent, width: 0.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(80),
                                      borderSide:
                                          const BorderSide(color: Colors.transparent, width: 0.0),
                                    ),
                                    // disabledBorder: new InputBorder(borderSide: BorderSide.none),
                                    hintStyle: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                                    filled: true,
                                    fillColor: darkGrey,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 17, vertical: 12),
                                    hintText: "Enter your last name",
                                  ),
                                  onChanged: (value) async{
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    await prefs.setString('lastName', value);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 15, bottom: 5),
                              child: Text(
                                "Mobile Number",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8, right: 8, bottom: 15),
                              child: Container(
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  child: TextFormField(
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(80),
                                      borderSide:
                                          const BorderSide(color: Colors.transparent, width: 0.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(80),
                                      borderSide:
                                          const BorderSide(color: Colors.transparent, width: 0.0),
                                    ),
                                    // disabledBorder: new InputBorder(borderSide: BorderSide.none),
                                    hintStyle: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                                    filled: true,
                                    fillColor: darkGrey,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 17, vertical: 12),
                                    hintText: "Enter your 10-digit mobile number",
                                  ),
                                  onChanged: (value) {
                                    this.mobileNo = value;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 45,
                        child: RoundedLoadingButton(
                          controller: _btnController, 
                          onPressed: () async {
                            if (this.mobileNo.toString().length != 10){
                              Fluttertoast.showToast(
                                msg: "Enter your 10 digit number only",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM, 
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey[200],
                                textColor: Colors.red,
                                fontSize: 12.0
                              );
                            }
                            else{
                              var tenant = await getTenantProfile(this.mobileNo.toString());
                              if (tenant != null){
                                print("Old User Login");
                                    Fluttertoast.showToast(
                                      msg: "Seems you are already registered, please login",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM, 
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey[200],
                                      textColor: primaryColor,
                                      fontSize: 12.0
                                  );
                              }
                              else{
                                _btnController.success();
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.leftToRightWithFade,
                                        child: OTPScreen(mobileNo: this.mobileNo, mode: "Register")));
                              }
                            }
                          },
                          color: primaryColor,
                          child: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Send OTP",
                                  style: TextStyle(
                                      color: white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                bottom: 0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Divider(
                        height: 0.5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Already have a account?",
                            style: TextStyle(),
                          ),
                          FlatButton(
                            padding: EdgeInsets.only(right: 20),
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeftWithFade,
                                      child: LoginScreen()));
                            },
                            child: Text(
                              "Login ",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}

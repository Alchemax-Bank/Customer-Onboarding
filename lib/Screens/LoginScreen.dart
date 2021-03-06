import 'dart:convert';

import 'package:Nirvana/Screens/OTPScreen.dart';
import 'package:Nirvana/Services/tenantProfile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:page_transition/page_transition.dart';
import 'package:Nirvana/constants.dart';
import 'package:Nirvana/Screens/RegisterScreen.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String mobileNo;
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double abovePadding = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom +
        30;
    //print(abovePadding);
    double leftHeight = screenHeight - abovePadding;
    return Scaffold(
        backgroundColor: white,
        appBar: null,
        body: SingleChildScrollView(
          // physics: BouncingScrollPhysics(),
          child: Stack(
            children: <Widget>[
              Container(
                height: leftHeight,
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.only(top: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/banner.png"),
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
                        "Welcome Back",
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
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
                          child: TextFormField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
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
                              hintText: "Enter 10-digit mobile number",
                            ),
                            onChanged: (value) {
                                  this.mobileNo = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
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
                              if (tenant == null){
                                print("New User Login");
                                    Fluttertoast.showToast(
                                      msg: "Seems you are new here, please register",
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
                                        type: PageTransitionType.rightToLeftWithFade,
                                        child: OTPScreen(mobileNo: this.mobileNo, mode: "Login")));
                              }
                            }
                          },
                          color: primaryColor,
                          child: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Send OTP",
                                  style: TextStyle(
                                      letterSpacing: 1,
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
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have a account?"),
                          FlatButton(
                            padding: EdgeInsets.only(right: 20),
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.leftToRightWithFade,
                                      child: RegisterScreen()));
                            },
                            child: Text(
                              "Register ",
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
          ),
        )
      );
  }
}

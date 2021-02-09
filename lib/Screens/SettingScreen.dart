import 'package:Nirvana/Screens/Drawer.dart';
import 'package:Nirvana/Screens/NotificationScreen.dart';
import 'package:Nirvana/Services/tenantProfile.dart';
import 'package:Nirvana/constants.dart';
import 'package:Nirvana/models/Tenant.dart';
import 'package:flutter/material.dart';
import 'package:Nirvana/Widget/SettingsDivider.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Nirvana/Screens/ProfileScreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:Nirvana/Services/Login.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Tenant tenant;
  
  @override
  void initState() {
    super.initState();
    initialise();
  }
  
  void initialise() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var mobile = prefs.getString("mobile");
    Tenant tmp = await getTenantProfile(mobile);
    setState(() {
      tenant = tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavigationDrawer(),
      body: tenant != null ? SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
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
                          "Settings",
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
              ],
            ),
            SettingsDivider(dividerTitle: "PERSONAL"),
            Container(
                margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text("Name",
                            style: TextStyle(color: primaryColor, fontSize: 15)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text(this.tenant.username,
                            style: TextStyle(color: Colors.black, fontSize: 15)),
                      ),
                    )
                  ],
                )),
            Container(
                margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text("Phone Number",
                            style: TextStyle(color: primaryColor, fontSize: 15)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text("+91 " + this.tenant.phone_no,
                            style: TextStyle(color: Colors.black, fontSize: 15)),
                      ),
                    )
                  ],
                )
              ),
            Container(
                margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text("Address",
                            style: TextStyle(color: primaryColor, fontSize: 15)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text(this.tenant.address !=null ? this.tenant.address : "Not Available" ,
                            style: TextStyle(color: Colors.black, fontSize: 15)),
                      ),
                    )
                  ],
                )),
            Container(
                margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text("Gender",
                            style: TextStyle(color: primaryColor, fontSize: 15)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text(this.tenant.gender !=null ? this.tenant.gender : "Not Available" ,
                            style: TextStyle(color: Colors.black, fontSize: 15)),
                      ),
                    )
                  ],
                )
              ),
              Container(
                margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text(this.tenant.is_verified != null ? "Nirvana Verified" : "Verification needed",
                            style: TextStyle(color: primaryColor, fontSize: 12, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: this.tenant.is_verified != null ?
                        Icon(Icons.verified_user, color: primaryColor) :
                        Container()
                    )
                  ],
                )
              ),
              Container(
                margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                child: FlatButton(
                      child : Text("Update Account", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),),
                      onPressed: (){
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                              type: PageTransitionType.leftToRightWithFade,
                              child: ProfileScreen(tenant: tenant,)));
                      },
                      color: primaryColor,
                )
              ),
            Padding(padding: EdgeInsets.all(8)),
            SettingsDivider(dividerTitle: "NOTIFICATIONS"),
            Container(
                margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text("Push Notifications",
                            style: TextStyle(color: Colors.black, fontSize: 15)),
                      ),
                    ),
                    Container(
                      child: Switch(value: true, onChanged: (bool value) {}),
                    )
                  ],
                )),
            SettingsDivider(dividerTitle: "OTHER"),
            Container(
              margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
              alignment: Alignment.topLeft,
              child: ListTile(
                title: Text('Logout'),
                onTap: () {
                  LoginFunctions loginFunctions = new LoginFunctions();
                  loginFunctions.signOut(context);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
              alignment: Alignment.topLeft,
              child: ListTile(
                title: Text('Refer the App !'),
                onTap: () {

                },
              ),
            ),
            Padding(padding: EdgeInsets.all(8)),
            SettingsDivider(dividerTitle: "FEEDBACK"),
            Container(
              margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
              alignment: Alignment.topLeft,
              child: ListTile(
                title: Text('Chat with us !'),
                onTap: () {
                  
                },
              ),
            ),
          ],
        ),
      ) : Container(
            child: SpinKitDoubleBounce(
              color: primaryColor,
              size: 50.0,
            )
          ),
    );
  }
}
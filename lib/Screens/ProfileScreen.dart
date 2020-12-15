import 'dart:async';
import 'dart:convert';
import 'package:Nirvana/Services/tenantProfile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xml2json/xml2json.dart';
import 'package:Nirvana/Screens/Home.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:Nirvana/constants.dart';
import 'package:Nirvana/models/Tenant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  final Tenant tenant;
  ProfileScreen({this.tenant});
  @override
  _ProfileState createState() => new _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {
  var barcode = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var data;
  var gender = "Male";
  var username;
  var address;
  var tenantProfile;

  @override
  void initState() {
    super.initState();
    initialise();
  }
  
  void initialise() async {
    
  }
  
  DateTime dob = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: dob,
        firstDate: DateTime(1901, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != dob)
      setState(() {
        dob = picked;
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
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
                              Icons.navigate_before,
                              size: 24,
                              color: white,
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  type: PageTransitionType.leftToRightWithFade,
                                  child: Home(index:3)));
                            },
                          ),
                        ),
                        title: Text(
                          "Account Profile",
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
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/account.png"),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter),
                ),
                child: null
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                    color: primaryColor,
                    textColor: Colors.white,
                    onPressed: scan,
                    child: const Text('Import Profile (Using Aadhar)')
                ),
            ),
            SizedBox(
              height: 20,
            ),
            this.data !=null ? Column(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 5),
                      child: Text(
                        "Name",
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
                          width: MediaQuery.of(context).size.width * 0.8,
                          child:  TextFormField(
                          initialValue: this.username ,
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
                          ),
                          onChanged: (value) async{
                            setState(() {
                              this.username = value;
                            });
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
                        "Gender",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 8, bottom: 15),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: DropdownButton<String>(
                            value: this.gender,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(
                              color: Colors.black
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                this.gender = newValue;
                              });
                            },
                            items: <String>['Male', 'Female', 'Other']
                              .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              })
                              .toList(),
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
                        "Address",
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
                          width: MediaQuery.of(context).size.width * 0.8,
                          child:  TextFormField(
                          initialValue: this.address ,
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
                          ),
                          onChanged: (value) async{
                            setState(() {
                              this.address = value;
                            });
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
                        "Date of Birth",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 8, bottom: 15),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(width: 20.0,),
                            IconButton(
                              onPressed: () => _selectDate(context),
                              icon: Icon(Icons.calendar_today),
                            ),
                            SizedBox(width: 20.0,),
                            Text("${dob.toLocal()}".split(' ')[0]),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            
          ): Container(),
          this.data !=null ? Container(
            margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
            child: FlatButton(
                  child : Text("Update Account", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),),
                  onPressed: (){
                    //update account
                    var profile ={
                      "id": widget.tenant.id,
                      "username" : this.username,
                      "dob" : this.dob.toLocal().toString().split(' ')[0],
                      "gender" : this.gender,
                      "address" : this.address,
                      "nationality" : "Indian",
                    };
                    var tmp = updateTenantProfile(profile);
                    setState((){
                        this.tenantProfile = tmp;
                    });
                    Fluttertoast.showToast(
                        msg: "Tenant Profile Updated",
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
                          child: Home(index: 3)));
                  },
                  color: primaryColor,
            )
          ): Container(),
          ],
          )
        )
      );
  }

  Future scan() async {
    try {
      var barcode = await BarcodeScanner.scan();
      print(barcode.rawContent);
      Xml2Json xml2json = new Xml2Json();
      xml2json.parse(barcode.rawContent);
      var json = xml2json.toBadgerfish(); 
      print(json);
      var response = jsonDecode(json)['PrintLetterBarcodeData'];
      print(response);
      setState(() => this.barcode = barcode.rawContent);
      setState(() => this.data = response);
      setState(() => this.dob = DateFormat('d/MM/yyyy').parse(data['@dob']));
      setState(() => this.username = data['@name']);
      setState(() => this.gender = this.data['@gender'] == 'M' ? "Male" : "Female");
      setState(() => this.address = this.data.containsKey('@loc') ? this.data['@loc'] : this.data['@house'].toString() + ', ' + this.data['@street'] + ', '+ this.data['@lm'] + ', ' + this.data['@subdist'] + ', ' + this.data['@state']);
      print(data);

    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}
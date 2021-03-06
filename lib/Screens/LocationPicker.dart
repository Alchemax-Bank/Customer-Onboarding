import 'package:Nirvana/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Nirvana/Services/LocationAutoComplete.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as Coding;

class LocationPicker extends StatefulWidget {
  final String header;
  LocationPicker({this.header});
  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  double w,h;
  String origin;
  Map<String, double> originCoordinates = {
    'latitude': 0.0,
    'longitude': 0.0
  };

  dynamic places;

  String pattern = "";
  final TextEditingController _typeAheadController1 = TextEditingController();

  Location location = new Location();
  List<Coding.Placemark> placemarks;

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  var currentLocation = [];

  @override
  void initState() {
    super.initState();
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
    placemarks = await Coding.placemarkFromCoordinates(_locationData.latitude, _locationData.longitude);
    await addData();
  }

  addData() async {
    currentLocation.insert(0, placemarks[0].name + ', ' +placemarks[0].subLocality + ', ' +placemarks[0].locality);
    currentLocation.insert(1, _locationData.latitude);
    currentLocation.insert(2, _locationData.longitude);
    currentLocation.length == 3 ? Navigator.pop(context, currentLocation) : addData();
  }

  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        elevation: 0,
        title: Text(widget.header,
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: w,
              height: h * 0.20,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/location.png"),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter),
              ),
              child: null
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 0.1 * w, right: 0.1 * w, top: 0.05 * h),
            decoration: new BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  color: primaryColor,
                  blurRadius: 15.0,
                  spreadRadius: -5
                ),
              ],
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: TextField(
                    autofocus: true,
                    decoration:InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your location here",
                      hintStyle: TextStyle(
                        color: primaryColor,
                        fontSize: 18
                      ) 
                    ),
                    controller: this._typeAheadController1,
                    onChanged: (value) {
                      setState(() {
                        pattern = value;
                      });
                    },
                )
              ),
            ),
          ),
          currentLocation.length !=3 ? GestureDetector(
            onTap: () => {
              currentLoc()
            },
            child: Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_searching),
                  Text(" Your current location")
                ],
              ),
            ),
          ) : SpinKitDoubleBounce(
            color: primaryColor,
            size: 50.0,
          ),
          FutureBuilder(
            future: pattern == "" ? null : AutoComplete.getSuggestions(pattern),
            builder: (context, snapshot) => pattern == "" ? Container(): 
              snapshot.hasData ? Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        currentLocation.insert(0, snapshot.data[index]['poi']['name'].toString() + ', ' + snapshot.data[index]['address']['freeformAddress'].toString());
                        currentLocation.insert(1, snapshot.data[index]['position']['lat']);
                        currentLocation.insert(2, snapshot.data[index]['position']['lon']);
                      });
                      print(snapshot.data[index]);
                      Navigator.pop(context, currentLocation);
                    },
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Text(snapshot.data[index]['poi']['name'].toString() + ', ' + snapshot.data[index]['address']['freeformAddress'].toString(),
                        style: TextStyle(
                          fontSize: 16
                        )
                      )
                    ),
                  ),
                  itemCount: snapshot.data.length,
                )
              ) : SpinKitThreeBounce(
                  color: primaryColor,
                  size: 50.0,
                ),
          )
        ],
      ),
    );
  }
}
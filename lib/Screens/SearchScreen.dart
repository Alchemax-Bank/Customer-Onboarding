import 'package:Nirvana/Screens/Drawer.dart';
import 'package:Nirvana/Screens/PropertyDetailScreen.dart';
import 'package:Nirvana/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  
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
      body: Column(
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
                        "Search",
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
          
          Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300])
                ),
                prefixIcon: Icon(Icons.search, color: Colors.grey[500],),
                suffixIcon: Icon(Icons.filter_list, color: primaryColor,),
                hintText: "Enter location",
                focusColor: primaryColor
              ),
            ),
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 32, right:32, top: 16, bottom: 16),
            color: Colors.grey[100],
            child: Text("100 Results Found", style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold),),
          ),

          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              color: Colors.grey[100],
              child: ListView.separated(
                  itemBuilder: (context, index){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.favorite_border, color: index %2 == 0  ? Colors.grey[400] : Colors.redAccent,), onPressed: () {  },
                            ),

                            Container(
                              width: 90,
                              height: 90,
                              child: GestureDetector(
                                child: ClipOval(
                                  child: Image.asset("assets/${index+1}.jpg", fit: BoxFit.cover,),
                                ),
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PropertyDetailScreen()
                                  ));
                                },
                              )
                            ),

                            SizedBox(width: 20,),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Preimer Towers", style: TextStyle(fontSize: 22, color: Colors.grey[800], fontWeight: FontWeight.bold),),
                                  Text("Nipania, Indore, 452010", style: TextStyle(color: Colors.grey[500],), overflow: TextOverflow.ellipsis,),
                                  SizedBox(height: 8,),
                                  Text("3,000 Rs /day", style: TextStyle(fontSize: 18, color: primaryColor, fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),

                            IconButton(icon: Icon(Icons.navigation), onPressed: () {  },)
                          ],
                        ),

                        SizedBox(height: 12,),

                        Container(
                          margin: EdgeInsets.only(left: 32, right: 16),
                          child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(Icons.people, size: 12, color: Colors.grey[600],),
                                  SizedBox(width: 4,),
                                  Text("5 people", style: TextStyle(color: Colors.grey[600]),)
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.local_offer, size: 12, color: Colors.grey[600],),
                                  SizedBox(width: 4,),
                                  Text("2 Beds", style: TextStyle(color: Colors.grey[600]),)
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.airline_seat_legroom_reduced, size: 12, color: Colors.grey[600],),
                                  SizedBox(width: 4,),
                                  Text("2 Bathrooms", style: TextStyle(color: Colors.grey[600]),)
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 16,)
                      ],

                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: 5


              ),
            ),
          )
        ],
      ),
    );
  }
}
import 'dart:convert';
import 'package:Nirvana/constants.dart';
import 'package:http/http.dart';
import 'package:Nirvana/models/Property.dart';

Future<Property> getProperty(var property_id) async {
  Property property;
  try {
    final url = (server+"/property/" + property_id);
    Response response = await get(Uri.encodeFull(url), headers: {"Content-Type": "application/json", "Connection": "Keep-Alive"},);
    print(response.body);
    Map<String, dynamic> data = jsonDecode(response.body)["data"];
    property = new Property(
        index: data["index"],
        name: data["name"],
        bhk: data["BHK"],
        type: data["type"],
        floor: data["floor"],
        description: data["description"],
        latitude: data["latitude"],
        longitude: data["longitude"],
        location: data["location"],
        city: data["city"],
        pincode: data["pincode"],
        state: data["state"],
        country: data["country"],
        numberOfRooms: data["numberOfRooms"],
        landlord_id: data["landlord_id"],
        landmark_id: data["landmark_id"],
        price: data["price"],
        area_in_sqft: data["area_in_sqft"],
        status: data["status"],
        deposit: data["deposit"],
        bathrooms: data['bathrooms'],
        facing: data["facing"],
        photos_urls: data["photos_urls"],
        rating: data["rating"],
        remarks: data["remarks"],
        is_verified: data["is_verified"],
        is_accquired: data["is_accquired"],
        created_at: data["created_at"],
        updated_at: data["updated_at"],
        landlord_name : data["landlord_name"],
        landlord_phone : data["landlord_phone"],
        landlord_rating : data["landlord_rating"],
        landlord_type : data["landlord_type"]
      );
  } catch (e) {
    print(e);
  }
  return property;
}

Future<List<Property>> getProperties(Map<String, dynamic> order) async {
  List<Property> reports = [];
  try {
    final url = (server+"/properties");
    Response response = await post(Uri.encodeFull(url), body: json.encode(order), headers: {"Content-Type": "application/json", "Connection": "Keep-Alive"},);
    List data = jsonDecode(response.body)["data"];
    for (int i = 0; i < data.length; i++) {
      Property _property = new Property(
            index: data[i]["index"],
            name: data[i]["name"],
            bhk: data[i]["BHK"],
            type: data[i]["type"],
            floor: data[i]["floor"],
            description: data[i]["description"],
            latitude: data[i]["latitude"],
            longitude: data[i]["longitude"],
            location: data[i]["location"],
            city: data[i]["city"],
            pincode: data[i]["pincode"],
            state: data[i]["state"],
            country: data[i]["country"],
            numberOfRooms: data[i]["numberOfRooms"],
            landlord_id: data[i]["landlord_id"],
            landmark_id: data[i]["landmark_id"],
            price: data[i]["price"],
            area_in_sqft: data[i]["area_in_sqft"],
            status: data[i]["status"],
            deposit: data[i]["deposit"],
            bathrooms: data[i]['bathrooms'],
            facing: data[i]["facing"],
            photos_urls: data[i]["photos_urls"],
            rating: data[i]["rating"],
            remarks: data[i]["remarks"],
            is_verified: data[i]["is_verified"],
            is_accquired: data[i]["is_accquired"],
            created_at: data[i]["created_at"],
            updated_at: data[i]["updated_at"],
            landlord_name : data[i]["landlord_name"],
            landlord_phone : data[i]["landlord_phone"],
            landlord_rating : data[i]["landlord_rating"],
            landlord_type : data[i]["landlord_type"]
      );
      reports.add(_property);
    }
  } catch (e) {
    print(e);
  }
  return reports;
}

Future<List<Property>> getFilteredProperties(Map<String, dynamic> filter) async {
  List<Property> reports = [];
  try {
    final url = (server+"properties/apply_filter");
    Response response = await post(Uri.encodeFull(url), body: json.encode(filter), headers: {"Content-Type": "application/json", "Connection": "Keep-Alive"},);
    List data = jsonDecode(response.body)["data"];
    for (int i = 0; i < data.length; i++) {
      Property _property = new Property(
            index: data[i]["index"],
            name: data[i]["name"],
            bhk: data[i]["BHK"],
            type: data[i]["type"],
            floor: data[i]["floor"],
            description: data[i]["description"],
            latitude: data[i]["latitude"],
            longitude: data[i]["longitude"],
            location: data[i]["location"],
            city: data[i]["city"],
            pincode: data[i]["pincode"],
            state: data[i]["state"],
            country: data[i]["country"],
            numberOfRooms: data[i]["numberOfRooms"],
            landlord_id: data[i]["landlord_id"],
            landmark_id: data[i]["landmark_id"],
            price: data[i]["price"],
            area_in_sqft: data[i]["area_in_sqft"],
            status: data[i]["status"],
            deposit: data[i]["deposit"],
            bathrooms: data[i]['bathrooms'],
            facing: data[i]["facing"],
            photos_urls: data[i]["photos_urls"],
            rating: data[i]["rating"],
            remarks: data[i]["remarks"],
            is_verified: data[i]["is_verified"],
            is_accquired: data[i]["is_accquired"],
            created_at: data[i]["created_at"],
            updated_at: data[i]["updated_at"],
            landlord_name : data[i]["landlord_name"],
            landlord_phone : data[i]["landlord_phone"],
            landlord_rating : data[i]["landlord_rating"],
            landlord_type : data[i]["landlord_type"]

      );
      reports.add(_property);
    }
  } catch (e) {
    print(e);
  }
  return reports;
}

Future<List<Property>> getPopularProperties(Map<String, double> origin) async {
  List<Property> reports = [];
  try {
    final url = (server+"properties/popular");
    Map<String, dynamic> raw = {
      "origin" : origin
    };
    Response response = await post(Uri.encodeFull(url), body: json.encode(raw), headers: {"Content-Type": "application/json", "Connection": "Keep-Alive"},);
    List data = jsonDecode(response.body)["data"];
    for (int i = 0; i < data.length; i++) {
      Property _property = new Property(
            index: data[i]["index"],
            name: data[i]["name"],
            bhk: data[i]["BHK"],
            type: data[i]["type"],
            floor: data[i]["floor"],
            description: data[i]["description"],
            latitude: data[i]["latitude"],
            longitude: data[i]["longitude"],
            location: data[i]["location"],
            city: data[i]["city"],
            pincode: data[i]["pincode"],
            state: data[i]["state"],
            country: data[i]["country"],
            numberOfRooms: data[i]["numberOfRooms"],
            landlord_id: data[i]["landlord_id"],
            landmark_id: data[i]["landmark_id"],
            price: data[i]["price"],
            area_in_sqft: data[i]["area_in_sqft"],
            status: data[i]["status"],
            deposit: data[i]["deposit"],
            bathrooms: data[i]['bathrooms'],
            facing: data[i]["facing"],
            photos_urls: data[i]["photos_urls"],
            rating: data[i]["rating"],
            remarks: data[i]["remarks"],
            is_verified: data[i]["is_verified"],
            is_accquired: data[i]["is_accquired"],
            created_at: data[i]["created_at"],
            updated_at: data[i]["updated_at"],
            landlord_name : data[i]["landlord_name"],
            landlord_phone : data[i]["landlord_phone"],
            landlord_rating : data[i]["landlord_rating"],
            landlord_type : data[i]["landlord_type"]
      );
      reports.add(_property);
    }
  } catch (e) {
    print(e);
  }
  return reports;
}

Future<List<Property>> getPremiumProperties(Map<String, double> origin) async {
  List<Property> reports = [];
  try {
    final url = (server+"properties/premium");
    Map<String, dynamic> raw = {
      "origin" : origin
    };
    Response response = await post(Uri.encodeFull(url), body: json.encode(raw), headers: {"Content-Type": "application/json", "Connection": "Keep-Alive"},);
    List data = jsonDecode(response.body)["data"];
    for (int i = 0; i < data.length; i++) {
      Property _property = new Property(
            index: data[i]["index"],
            name: data[i]["name"],
            bhk: data[i]["BHK"],
            type: data[i]["type"],
            floor: data[i]["floor"],
            description: data[i]["description"],
            latitude: data[i]["latitude"],
            longitude: data[i]["longitude"],
            location: data[i]["location"],
            city: data[i]["city"],
            pincode: data[i]["pincode"],
            state: data[i]["state"],
            country: data[i]["country"],
            numberOfRooms: data[i]["numberOfRooms"],
            landlord_id: data[i]["landlord_id"],
            landmark_id: data[i]["landmark_id"],
            price: data[i]["price"],
            area_in_sqft: data[i]["area_in_sqft"],
            status: data[i]["status"],
            deposit: data[i]["deposit"],
            bathrooms: data[i]['bathrooms'],
            facing: data[i]["facing"],
            photos_urls: data[i]["photos_urls"],
            rating: data[i]["rating"],
            remarks: data[i]["remarks"],
            is_verified: data[i]["is_verified"],
            is_accquired: data[i]["is_accquired"],
            created_at: data[i]["created_at"],
            updated_at: data[i]["updated_at"],
            landlord_name : data[i]["landlord_name"],
            landlord_phone : data[i]["landlord_phone"],
            landlord_rating : data[i]["landlord_rating"],
            landlord_type : data[i]["landlord_type"]
      );
      reports.add(_property);
    }
  } catch (e) {
    print(e);
  }
  return reports;
}

import 'dart:convert';
import 'package:Nirvana/constants.dart';
import 'package:http/http.dart';
import 'package:Nirvana/models/Property.dart';

Future<Property> getProperty(var property_id) async {
  Property property;
  try {
    final url = (server+"properties/get/" + property_id.toString());
    Response response = await get(Uri.encodeFull(url), headers: {"Content-Type": "application/json", "Connection": "Keep-Alive"},);
    print(response.body);
    Map<String, dynamic> data = jsonDecode(response.body)["data"];
    property = new Property(
        index: data["id"],
        name: data["name"],
        bhk: data["bhk"],
        type: data["type"],
        description: data["description"],
        latitude: data["latitude"],
        longitude: data["longitude"],
        location: data["address"],
        city: data["city"],
        state: data["state"],
        price: data["price"],
        area_in_sqft: data["areaSqFt"],
        status: data["furnishedStatus"],
        deposit: data["deposit"],
        bathrooms: data['bathrooms'],
        rating: data["rating"],
        remarks: data["remarks"],
        is_accquired: data["availabilityStatus"],
        numberOfRooms: data["existingPeople"],
        created_at: data["registrationDate"],
        updated_at: data["updatedTime"],
        landlord_id: data["landlord"]["id"],
        landlord_name : data["landlord"]["username"],
        landlord_phone : data["landlord"]["phoneNo"],
        landlord_rating : data["landlord"]["rating"],
        landlord_type : "AGENT"
      );
  } catch (e) {
    print(e);
  }
  return property;
}

Future<List<Property>> getProperties(Map<String, dynamic> origin) async {
  List<Property> reports = [];
  try {
    final url = (server+"properties/get");
    Response response = await post(Uri.encodeFull(url), body: json.encode(origin), headers: {"Content-Type": "application/json", "Connection": "Keep-Alive"},);
    List data = jsonDecode(response.body);
    for (int i = 0; i < data.length; i++) {
      Property _property = new Property(        
        index: data[i]["id"],
        name: data[i]["name"],
        bhk: data[i]["bhk"],
        type: data[i]["type"],
        description: data[i]["description"],
        latitude: data[i]["latitude"],
        longitude: data[i]["longitude"],
        location: data[i]["address"],
        city: data[i]["city"],
        state: data[i]["state"],
        price: data[i]["price"],
        area_in_sqft: data[i]["areaSqFt"],
        status: data[i]["furnishedStatus"],
        deposit: data[i]["deposit"],
        bathrooms: data[i]['bathrooms'],
        rating: data[i]["rating"],
        remarks: data[i]["remarks"],
        is_accquired: data[i]["availabilityStatus"],
        numberOfRooms: data[i]["existingPeople"],
        created_at: data[i]["registrationDate"],
        updated_at: data[i]["updatedTime"],
        landlord_id: data[i]["landlord"]["id"],
        landlord_name : data[i]["landlord"]["username"],
        landlord_phone : data[i]["landlord"]["phoneNo"],
        landlord_rating : data[i]["landlord"]["rating"],
        landlord_type : "AGENT"
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
    final url = ("http://20.185.230.90:5003/api/properties/apply_filter");
    Response response = await post(Uri.encodeFull(url), body: json.encode(filter), headers: {"Content-Type": "application/json", "Connection": "Keep-Alive"},);
    List data = jsonDecode(response.body)["data"];
    for (int i = 0; i < data.length; i++) {
      Property _property = new Property(
        index: data[i]["index"],
        name: data[i]["name"],
        bhk: data[i]["BHK"],
        type: data[i]["type"],
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
        landlord_type : "AGENT",
        landmark: data[i]["landmark"]
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
    final url = (server+"properties/popular?lat=" + origin['latitude'].toString() + '&long=' + origin['longitude'].toString());
    Response response = await get(Uri.encodeFull(url), headers: {"Content-Type": "application/json", "Connection": "Keep-Alive"},);
    List data = jsonDecode(response.body)["data"];
    for (int i = 0; i < data.length; i++) {
      Property _property = new Property(
        index: data[i]["id"],
        name: data[i]["name"],
        bhk: data[i]["bhk"],
        type: data[i]["type"],
        description: data[i]["description"],
        latitude: data[i]["latitude"],
        longitude: data[i]["longitude"],
        location: data[i]["address"],
        city: data[i]["city"],
        state: data[i]["state"],
        price: data[i]["price"],
        area_in_sqft: data[i]["areaSqFt"],
        status: data[i]["status"],
        deposit: data[i]["deposit"],
        bathrooms: data[i]['bathrooms'],
        rating: data[i]["rating"],
        remarks: data[i]["remarks"],
        is_accquired: data[i]["availabilityStatus"],
        numberOfRooms: data[i]["existingPeople"],
        created_at: data[i]["registrationDate"],
        updated_at: data[i]["updatedTime"],
        landlord_id: data[i]["landlord"]["id"],
        landlord_name : data[i]["landlord"]["username"],
        landlord_phone : data[i]["landlord"]["phoneNo"],
        landlord_rating : data[i]["landlord"]["rating"],
        landlord_type : "AGENT"
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
    final url = (server+"properties/premium?lat=" + origin['latitude'].toString() + '&long=' + origin['longitude'].toString());
    Response response = await get(Uri.encodeFull(url), headers: {"Content-Type": "application/json", "Connection": "Keep-Alive"},);
    List data = jsonDecode(response.body)["data"];
    //print(data);
    for (int i = 0; i < data.length; i++) {
      Property _property = new Property(
        index: data[i]["id"],
        name: data[i]["name"],
        bhk: data[i]["bhk"],
        type: data[i]["type"],
        description: data[i]["description"],
        latitude: data[i]["latitude"],
        longitude: data[i]["longitude"],
        location: data[i]["address"],
        city: data[i]["city"],
        state: data[i]["state"],
        price: data[i]["price"],
        area_in_sqft: data[i]["areaSqFt"],
        status: data[i]["status"],
        deposit: data[i]["deposit"],
        bathrooms: data[i]['bathrooms'],
        rating: data[i]["rating"],
        remarks: data[i]["remarks"],
        is_accquired: data[i]["availabilityStatus"],
        numberOfRooms: data[i]["existingPeople"],
        created_at: data[i]["registrationDate"],
        updated_at: data[i]["updatedTime"],
        landlord_id: data[i]["landlord"]["id"],
        landlord_name : data[i]["landlord"]["username"],
        landlord_phone : data[i]["landlord"]["phoneNo"],
        landlord_rating : data[i]["landlord"]["rating"],
        landlord_type : "AGENT"
      );
      reports.add(_property);
    }
  } catch (e) {
    print(e);
  }
  return reports;
}

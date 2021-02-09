import 'dart:convert';
import 'package:Nirvana/constants.dart';
import 'package:http/http.dart';
import 'package:Nirvana/models/Tenant.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Tenant> getTenantProfile(String mobile) async {
  Tenant tenant;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    final url = (server+"tenant/check_mobile/"+mobile);
    Response response = await get(Uri.encodeFull(url), headers: {"Content-Type": "application/json", "Connection": "Keep-Alive"},);
    print(response.body);
    bool status = jsonDecode(response.body)["status"];
    if (status){
      Map<String, dynamic> data = jsonDecode(response.body)["data"];
      tenant = new Tenant(
        id: data['id'],
        username: data["username"],
        address: data["address"], 
        phone_no: data["phoneNo"].toString(), 
        is_verified: data['verified'],
        budget: data["budget"],
        device_token: data["deviceToken"],
        dob: data["dob"],
        firebase_id: data["firebaseId"],
        gender: data["gender"],
        nationality: data["nationality"],
        registered_time: data["registeredTime"],
        updated_time: data['updatedTime'],
        property_id: data['property'] != null ? data['property']['id']: null 
      );
      await prefs.setInt('tenant_id', data['id']);
      await prefs.setString('username', data["username"]);
    }
  } catch (e) {
    print(e);
  }
  return tenant;
}

Future<Tenant> getTenantProfileById(String id) async {
  Tenant tenant;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    final url = (server+"tenant/get/"+id);
    Response response = await get(Uri.encodeFull(url), headers: {"Content-Type": "application/json", "Connection": "Keep-Alive"},);
    print(response.body);
    Map<String, dynamic> data = jsonDecode(response.body);
    tenant = new Tenant(
      id: data['id'],
      username: data["username"],
      address: data["address"], 
      phone_no: data["phoneNo"].toString(), 
      is_verified: data['verified'],
      budget: data["budget"],
      device_token: data["deviceToken"],
      dob: data["dob"],
      firebase_id: data["firebaseId"],
      gender: data["gender"],
      nationality: data["nationality"],
      registered_time: data["registeredTime"],
      updated_time: data['updatedTime'],
      property_id: data['property']['id']
    );
    await prefs.setInt('tenant_id', data['id']);
    await prefs.setString('username', data["username"]);
  } catch (e) {
    print(e);
  }
  return tenant;
}

Future<Tenant> updateTenantProfile(Map<String, dynamic> profile) async {
  Tenant tenant;
  try {
    final url = (server+"tenant/update");
    print(profile);
    
    Response response = await put(Uri.encodeFull(url), body: json.encode(profile), headers: {"Content-Type": "application/json", "Connection": "Keep-Alive"},);
    print(response.body);
    Map<String, dynamic> data = jsonDecode(response.body)["data"];
    tenant = new Tenant(  
      id: data['id'],
      username: data["username"],
      address: data["address"], 
      phone_no: data["phoneNo"].toString(), 
      is_verified: data['verified'],
      budget: data["budget"],
      device_token: data["deviceToken"],
      dob: data["dob"],
      firebase_id: data["firebaseId"],
      gender: data["gender"],
      nationality: data["nationality"],
      registered_time: data["registeredTime"],
      updated_time: data['updatedTime'],
      property_id: data['property']['id']
    );
  } catch (e) {
    print(e);
  }
  return tenant;
}

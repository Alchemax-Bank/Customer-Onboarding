import 'dart:convert';
import 'package:Nirvana/constants.dart';
import 'package:http/http.dart';
import 'package:Nirvana/models/Tenant.dart';

Future<Tenant> getTenantProfile(String mobile) async {
  Tenant tenant;
  try {
    final url = (server+"tenant/check_mobile/"+mobile);
    Response response = await get(Uri.encodeFull(url), headers: {"Content-Type": "application/json", "Connection": "Keep-Alive"},);
    print(response.body);
    Map<String, dynamic> data = jsonDecode(response.body)["data"];
    tenant = new Tenant(
          name: data["username"], address: data["address"], phone: data["phone_no"].toString(), verified: data['is_verified']);
  } catch (e) {
    print(e);
  }
  return tenant;
}
Future<Tenant> updateTenantProfile(Map<String, dynamic> profile) async {
  Tenant tenant;
  try {
    final url = (server+"tenant/update");
    Response response = await post(Uri.encodeFull(url), body: json.encode(profile), headers: {"Content-Type": "application/json", "Connection": "Keep-Alive"},);
    print(response.body);
    Map<String, dynamic> data = jsonDecode(response.body)["data"];
    tenant = new Tenant(
          name: data["username"], address: data["address"], phone: data["phone_no"].toString(), verified: data['is_verified']);
  } catch (e) {
    print(e);
  }
  return tenant;
}

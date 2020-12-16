import 'dart:convert';
import 'package:Nirvana/constants.dart';
import 'package:Nirvana/models/Booking.dart';
import 'package:http/http.dart';

Future<Map<String, dynamic>> bookAProperty(Map<String, dynamic> bookingInfo) async {
  Map<String, dynamic> data;
  try {
    final url = (server+"booking");
    print(bookingInfo);
    Response response = await post(Uri.encodeFull(url), body: json.encode(bookingInfo), headers: {"Content-Type": "application/json", "Connection": "Keep-Alive"},);
    print(response.body);
    data = jsonDecode(response.body);
    } catch (e) {
    print(e);
  }
  return data;
}

Future<Booking> getCurrentBooking(var tenant_id) async {
  Booking booking;
  try {
    final url = (server+"booking/current/" + tenant_id.toString());
    Response response = await get(Uri.encodeFull(url), headers: {"Content-Type": "application/json", "Connection": "Keep-Alive"},);
    print(response.body);
    Map<String, dynamic> data = jsonDecode(response.body)["data"];
    booking = new Booking(
        id: data["id"],
        tenant_id: data["tenant_id"],
        property_id: data["property_id"],
        check_in: data["check_in"],
        check_out: data["check_out"],
        comments: data["comments"],
        images: data["images"],
        created_time: data["created_time"],
        updated_time: data["updated_time"]
    );
    } catch (e) {
    print(e);
  }
  return booking;
}

Future<List<Booking>> getAllBooking(var tenant_id) async {
  List<Booking> booking = [];
  try {
    final url = (server+"booking/all/" + tenant_id.toString());
    Response response = await get(Uri.encodeFull(url), headers: {"Content-Type": "application/json", "Connection": "Keep-Alive"},);
    print(response.body);
    bool status = jsonDecode(response.body)["status"];
    if (status){
      List data = jsonDecode(response.body)["data"];
      for (int i = 0; i < data.length; i++) {
          Booking _booking = new Booking(
              id: data[i]["id"],
              tenant_id: data[i]["tenant_id"],
              property_id: data[i]["property_id"],
              check_in: data[i]["check_in"],
              check_out: data[i]["check_out"],
              comments: data[i]["comments"],
              images: data[i]["images"],
              created_time: data[i]["created_time"],
              updated_time: data[i]["updated_time"]
          );
          booking.add(_booking);
        }
      }
    } catch (e) {
    print(e);
  }
  return booking;
}


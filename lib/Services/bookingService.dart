import 'dart:convert';
import 'package:Nirvana/constants.dart';
import 'package:Nirvana/models/Booking.dart';
import 'package:http/http.dart';

Future<bool> bookAProperty(Map<String, dynamic> bookingInfo) async {
  bool data;
  try {
    final url = (server+"booking");
    print(bookingInfo);
    Response response = await post(Uri.encodeFull(url), body: json.encode(bookingInfo), headers: {"Content-Type": "application/json", "Connection": "Keep-Alive"},);
    print(response.body);
    data = jsonDecode(response.body)['status'];
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
        tenant_id: data["tenantId"],
        property_id: data["propertyId"],
        check_in: data["checkIn"],
        check_out: data["checkOut"],
        comments: data["comments"],
        images: data["images"],
        created_time: data["createdTime"],
        updated_time: data["updatedTime"]
    );
    } catch (e) {
    print(e);
  }
  return booking;
}

Future<List<Booking>> getAllBooking(var tenant_id) async {
  List<Booking> booking = [];
  try {
    final url = (server+"booking/?id=" + tenant_id.toString());
    Response response = await get(Uri.encodeFull(url), headers: {"Content-Type": "application/json", "Connection": "Keep-Alive"},);
    print(response.body);
    bool status = jsonDecode(response.body)["status"];
    if (status){
      List data = jsonDecode(response.body)["data"];
      for (int i = 0; i < data.length; i++) {
          Booking _booking = new Booking(
            tenant_id: data[i]["id"]["tenantId"],
            property_id: data[i]["id"]["propertyId"],
            check_in: data[i]["checkIn"],
            check_out: data[i]["checkOut"],
            comments: data[i]["comments"],
            images: data[i]["images"],
            created_time: data[i]["createdTime"],
            updated_time: data[i]["updatedTime"]
          );
          booking.add(_booking);
        }
      }
    } catch (e) {
    print(e);
  }
  return booking;
}


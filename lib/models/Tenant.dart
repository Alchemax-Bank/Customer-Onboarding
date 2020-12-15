import 'dart:core';

class Tenant{
  var username;
  var address;
  var phone_no;
  var id;
  var is_verified;
  var firebase_id;
  var gender;
  var dob;
  var nationality;
  var budget;
  var device_token;
  var registered_time;
  var updated_time;
  Tenant({
    this.id,
    this.username,
    this.address,
    this.is_verified,
    this.phone_no,
    this.budget,
    this.device_token,
    this.dob,
    this.firebase_id,
    this.gender,
    this.nationality,
    this.registered_time,
    this.updated_time
    });
}

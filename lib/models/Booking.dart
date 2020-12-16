import 'dart:core';

class Booking{
  var id;
  var tenant_id;
  var property_id;
  var check_in;
  var check_out;
  var comments;
  var images;
  var created_time;
  var updated_time;
  Booking({
    this.id,
    this.tenant_id,
    this.property_id,
    this.check_in,
    this.check_out,
    this.comments,
    this.images,
    this.created_time,
    this.updated_time
    });
}

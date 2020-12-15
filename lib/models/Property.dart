import 'dart:core';

class Property{
  var index;
  var name;
  var bhk;
  var type;
  var floor;
  var description;
  var latitude;
  var longitude;
  var location;
  var city;
  var pincode;
  var state;
  var country;
  var numberOfRooms;
  var landlord_id;
  var landmark_id;
  var price;
  var area_in_sqft;
  var status;
  var deposit;
  var bathrooms;
  var facing;
  var photos_urls;
  var rating;
  var remarks;
  var is_verified;
  var is_accquired;
  var created_at; 
  var updated_at;
  var landlord_name;
  var landlord_phone;
  var landlord_rating;
  var landlord_type;

  Property({
    this.index,
    this.name,
    this.bhk,
    this.type,
    this.floor,
    this.description,
    this.latitude,
    this.longitude,
    this.location,
    this.city,
    this.pincode,
    this.state,
    this.country,
    this.numberOfRooms,
    this.landlord_id,
    this.landmark_id,
    this.price,
    this.area_in_sqft,
    this.status,
    this.deposit,
    this.bathrooms,
    this.facing,
    this.photos_urls,
    this.rating,
    this.remarks,
    this.is_verified,
    this.is_accquired,
    this.created_at,
    this.updated_at,
    this.landlord_name,
    this.landlord_phone,
    this.landlord_rating,
    this.landlord_type
});
}

class PropertyDetail {
  final String image;
  final String title;
  final String description;

  PropertyDetail({this.image, this.title, this.description});
}

List<PropertyDetail> propertyDetails = [
  PropertyDetail(
      image: "assets/images/master_bedroom.jpg",
      title: "Master Bedroom",
      description: "Main big double bedroom with Landscape view"),
  PropertyDetail(
      image: "assets/images/hall.jpg",
      title: "Big Hall",
      description: "100*100 ft hall with italian marble flooring, Sofa"),
  PropertyDetail(
      image: "assets/images/kitchen.jpg",
      title: "Lavicent Kitchen",
      description: "Kitchen wiith all latest Equipment"),
];
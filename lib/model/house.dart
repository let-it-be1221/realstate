// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class House {
  final String uid;
  final String address;
  final double price;
  final int bed_rooms;
  final int bath_rooms;
  final int square_feet;
  final int kitchen;
  final int garages;
  final String description;
   bool isFav;
   bool status;
  //final String imageUrl;
  final List<String> imageUrls;
  final Timestamp postTime;
  final int phone_number;
  final String type;
  void toggleFavorite() {
    isFav = !isFav;
  }

  House(
      {required this.uid,
      required this.address,
      required this.price,
      required this.bed_rooms,
      required this.bath_rooms,
      required this.square_feet,
      required this.kitchen,
      required this.garages,
      required this.description,
      required this.imageUrls,
      required this.postTime,
      required this.isFav,
      required this.status,
      required this.phone_number,
      required this.type,});

  House copyWith({
    String? uid,
    String? address,
    double? price,
    int? bed_rooms,
    int? bath_rooms,
    int? square_feet,
    int? kitchen,
    int? garages,
    String? description,
    //String? imageUrl,
    List<String>? imageUrls,
    Timestamp? postTime,
    bool? isFav,
    bool? status,
    String? type,
  }) {
    return House(
      uid: uid ?? this.uid,
      address: address ?? this.address,
      price: price ?? this.price,
      bed_rooms: bed_rooms ?? this.bed_rooms,
      bath_rooms: bath_rooms ?? this.bath_rooms,
      square_feet: square_feet ?? this.square_feet,
      kitchen: kitchen ?? this.kitchen,
      garages: garages ?? this.garages,
      description: description ?? this.description,
      //imageUrl: imageUrl ?? this.imageUrl,
      imageUrls: imageUrls ?? this.imageUrls,
      postTime: postTime ?? this.postTime,
      isFav: isFav ?? this.isFav,
      status: status ?? this.status,
      phone_number: phone_number ?? this.phone_number,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'address': address,
      'price': price,
      'bed_rooms': bed_rooms,
      'bath_rooms': bath_rooms,
      'square_feet': square_feet,
      'kitchen': kitchen,
      'garages': garages,
      'description': description,
      //'imageUrl': imageUrl,
      'imageUrls': imageUrls,
      'postTime': postTime,
      'isFav': isFav,
      'status': status,
      'phone_number': phone_number,
      'type': type,
    };
  }

  factory House.fromMap(Map<String, dynamic> map) {
    return House(
      uid: map['uid'] as String,
      address: map['address'] as String,
      price: map['price'] as double,
      bed_rooms: map['bed_rooms'] as int,
      bath_rooms: map['bath_rooms'] as int,
      square_feet: map['square_feet'] as int,
      kitchen: map['kitchen'] as int,
      garages: map['garages'] as int,
      description: map['description'] as String,
      //imageUrl: map['imageUrl'] as String,
      imageUrls: List<String>.from(
        (map['imageUrls'] as List<dynamic>),
      ),
      postTime: map['postTime'],
      isFav: map['isFav'],
      status: map['status'] as bool,
      phone_number: map['phone_number'] as int,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory House.fromJson(String source) =>
      House.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'House(uid: $uid, address: $address, price: $price, bed_rooms: $bed_rooms, bath_rooms: $bath_rooms, square_feet: $square_feet, kitchen: $kitchen, garages: $garages, description: $description,  imageUrls: $imageUrls, postTime: $postTime, isFav: $isFav,status: $status, phone_number: $phone_number, type: $type)';
  }

  @override
  bool operator ==(covariant House other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.uid == uid &&
        other.address == address &&
        other.price == price &&
        other.bed_rooms == bed_rooms &&
        other.bath_rooms == bath_rooms &&
        other.square_feet == square_feet &&
        other.kitchen == kitchen &&
        other.garages == garages &&
        other.description == description &&
        //other.imageUrl == imageUrl &&
        listEquals(other.imageUrls, imageUrls) &&
        other.postTime == postTime &&
        other.isFav == isFav &&
        other.status == status &&
        other.phone_number == phone_number &&
        other.type == type;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        address.hashCode ^
        price.hashCode ^
        bed_rooms.hashCode ^
        bath_rooms.hashCode ^
        square_feet.hashCode ^
        kitchen.hashCode ^
        garages.hashCode ^
        description.hashCode ^
        //imageUrl.hashCode ^
        imageUrls.hashCode ^
        postTime.hashCode ^
        isFav.hashCode ^
        status.hashCode ^
        phone_number.hashCode ^
        type.hashCode;
  }
}

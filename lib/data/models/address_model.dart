

import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel{
  String city;

  String address;

  String addressName;

  String phoneNumber;

  String? apartment;

  String? entrance;

  String? floor;

  String? doorCode;

  String? note;

  int addressIcon;

  String firebaseName;

  AddressModel({
    required this.city,
    required this.address,
    required this.addressName,
    required this.phoneNumber,
    this.apartment,
    this.entrance,
    this.floor,
    this.doorCode,
    this.note,
    this.addressIcon = 0,
    required this.firebaseName
  });

  static Map<String, dynamic> addressModelToFireData(AddressModel addressModel){
    return {
      "city" : addressModel.city,
      "address" : addressModel.address,
      "addressName": addressModel.addressName,
      "phoneNumber" : addressModel.phoneNumber,
      "apartment" : addressModel.apartment,
      "entrance" : addressModel.entrance,
      "floor" : addressModel.floor,
      "doorCode" : addressModel.doorCode,
      "note": addressModel.note,
      "addressIcon" : addressModel.addressIcon,
      "firebaseName": addressModel.firebaseName
    };
  }

  factory AddressModel.fromFireDataToModel(QueryDocumentSnapshot documentSnapshot){

    final data = documentSnapshot.data() as Map;
    return AddressModel(
      city: data['city'],
      address: data['address'],
      addressName: data['addressName'],
      phoneNumber: data['phoneNumber'],
      apartment: data['apartment'],
      entrance: data['entrance'],
      floor: data['floor'],
      doorCode: data['doorCode'],
      note: data['note'],
      addressIcon: data['addressIcon'],
      firebaseName: data['firebaseName']
    );
  }
}
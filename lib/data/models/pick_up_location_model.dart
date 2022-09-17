
import 'package:flutter/material.dart';

class PickupLocationModel{

  int value;

  IconData icon;

  String locationName;

  String locationAddress;

  PickupLocationModel({
    required this.value,
    required this.icon,
    required this.locationName,
    required this.locationAddress
  });
}
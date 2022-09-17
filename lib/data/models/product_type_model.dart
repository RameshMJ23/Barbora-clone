
import 'package:flutter/material.dart';

class ProductTypeModel{

  String typeName;

  Widget? nextScreen;

  Widget? otherWidgets;

  bool isBold;

  ProductTypeModel({
    required this.typeName,
    this.otherWidgets,
    this.isBold = false,
    this.nextScreen
  });
}
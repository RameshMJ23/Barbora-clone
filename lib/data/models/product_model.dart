
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

enum UnitType{
  kg,
  units
}

class ProductModel extends Equatable{

  List<dynamic> bottomInfoContent;

  List<dynamic> bottomInfoContentEn;

  List<dynamic> bottomInfoTitle;

  List<dynamic> bottomInfoTitleEn;

  String image;

  bool isOffer;

  String net_cost;

  String? off_cost;

  String? off_percent;

  String original_cost;

  String title;

  String titleEn;

  List<dynamic>? upperInfoContent;

  List<dynamic>? upperInfoContentEn;

  List<dynamic>? upperInfoTitle;

  List<dynamic>? upperInfoTitleEn;

  String? validity;

  String maxQuantity;

  String id;

  UnitType unit;

  double measurement;

  double stepMeasurement;

  bool similar;

  ProductModel({
    required this.bottomInfoContent,
    required this.bottomInfoContentEn,
    required this.bottomInfoTitle,
    required this.bottomInfoTitleEn,
    required this.image,
    required this.isOffer,
    required this.net_cost,
    required this.off_cost,
    required this.off_percent,
    required this.original_cost,
    required this.title,
    required this.titleEn,
    required this.upperInfoContent,
    required this.upperInfoContentEn,
    required this.upperInfoTitle,
    required this.upperInfoTitleEn,
    required this.validity,
    required this.maxQuantity,
    required this.id,
    required this.unit,
    required this.measurement,
    required this.stepMeasurement,
    required this.similar
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    bottomInfoContent,
    bottomInfoContentEn,
    bottomInfoTitle,
    bottomInfoTitleEn,
    image,
    isOffer,
    net_cost,
    off_cost,
    off_percent,
    original_cost,
    title,
    titleEn,
    upperInfoContent,
    upperInfoContentEn,
    upperInfoTitle,
    upperInfoTitleEn,
    validity,
    maxQuantity,
    id,
    unit,
    measurement,
    stepMeasurement,
    similar
  ];

  factory ProductModel.productFromList(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map;
    return ProductModel(
      bottomInfoContent: data['bottom_info_content']['lt'],
      bottomInfoContentEn: data['bottom_info_content']['en'],
      bottomInfoTitle: data['bottom_info_title']['lt'],
      bottomInfoTitleEn: data['bottom_info_title']['en'],
      image: data['image'],
      isOffer: data['isOffer'],
      net_cost: data['net_cost'],
      off_cost: data['off_cost'],
      off_percent: data['off_percent'],
      original_cost: data['original_cost'],
      title: data['title'],
      titleEn: data['title_en'],
      upperInfoContent: (data['upper_info_content'] == null) ? null: data['upper_info_content']['lt'] ,
      upperInfoContentEn:(data['upper_info_content'] == null) ? null: data['upper_info_content']['en'],
      upperInfoTitle: (data['upper_info_title'] == null) ? null: data['upper_info_title']['lt'],
      upperInfoTitleEn: (data['upper_info_title'] == null) ? null: data['upper_info_title']['en'],
      validity: data['validity'],
      maxQuantity: data['max_quantity'],
      id: data['id'],
      unit: data['unit'] == "unit" ? UnitType.units : UnitType.kg,
      measurement: double.parse(data['measurement']),
      stepMeasurement: double.parse(data['step_measurement']),
      similar: data['similar']
    );
  }

  static Map<String, dynamic> productModelToFirebaseData(ProductModel productModel){
    return {
      "bottom_info_content": {
        "lt": productModel.bottomInfoContent,
        "en": productModel.bottomInfoContentEn
      },
      "bottom_info_title": {
        "lt": productModel.bottomInfoTitle,
        "en": productModel.bottomInfoTitleEn
      },
      "image": productModel.image,
      "isOffer": productModel.isOffer,
      "net_cost": productModel.net_cost,
      "off_cost": productModel.off_cost,
      "off_percent": productModel.off_percent,
      "original_cost": productModel.original_cost,
      "title": productModel.title,
      "title_en": productModel.titleEn,
      "upper_info_content": {
        "lt": productModel.upperInfoContent,
        "en": productModel.upperInfoContentEn
      },
      "upper_info_title": {
        "lt": productModel.upperInfoTitle,
        "en": productModel.upperInfoTitleEn
      },
      "validity": productModel.validity,
      "max_quantity": productModel.maxQuantity,
      "id": productModel.id,
      "unit": (productModel.unit == UnitType.kg) ? "kg": "unit",
      "measurement": (productModel.measurement + productModel.stepMeasurement).toStringAsFixed(1),
      "step_measurement": productModel.stepMeasurement.toString(),
      "similar": productModel.similar
    };
  }
}
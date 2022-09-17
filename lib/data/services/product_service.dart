import 'package:barboraapp/data/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class ProductService {

  String collectionName;

  ProductService({required this.collectionName});

  final FirebaseFirestore _ref = FirebaseFirestore.instance;

  List<ProductModel> _productListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map(ProductModel.productFromList).toList();
  }

  Stream<List<ProductModel>> getProducts(String? where) {

    final _localCollection = _ref.collection(collectionName);

    return where == null
      ?_localCollection.snapshots().map(
          _productListFromSnapshot
      )
      : _localCollection.where("type", isEqualTo: where).snapshots().map(
        _productListFromSnapshot
      );
  }
}


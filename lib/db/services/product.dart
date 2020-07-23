import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ProductService{
  Firestore _firestore = Firestore.instance;
  String productsCollection = "Products";
  String id = Uuid().v4();

  uploadProduct(Map<String, dynamic> data){
    _firestore.collection(productsCollection).document(id).setData(data);
  }
}
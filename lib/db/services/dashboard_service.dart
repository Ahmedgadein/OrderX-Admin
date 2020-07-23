import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class BoardService{
  Firestore _firestore = Firestore.instance;
  //Collections
  String categories = "Categories";
  String users = "Users";
  String brands = "Brands";

  Future<String> getCategoriesCount() async{
    try{
      List<DocumentSnapshot> _categories;
       await _firestore.collection(categories).getDocuments().then((value) => _categories = value.documents);
       return _categories.length.toString();
    }catch( e){
      print(e.toString());
    }
  }

  Future<String> getUsersCount() async{
    try{
      List<DocumentSnapshot> _users;
      await _firestore.collection(users).getDocuments().then((value) => _users = value.documents);
      return _users.length.toString();

    }catch( e){
      print(e.toString());
    }
  }

  Future<String> getProductsCount() async{
    try{
      List<DocumentSnapshot> _products;
      await _firestore.collection(users).getDocuments().then((value) => _products = value.documents);
      return _products.length.toString();

    }catch( e){
      print(e.toString());
    }
  }

  Future<String> getBrandsCount() async{
    try{
      List<DocumentSnapshot> _brands;
      await _firestore.collection(brands).getDocuments().then((value) => _brands = value.documents);
      return _brands.length.toString();

    }catch( e){
      print(e.toString());
    }
  }

}
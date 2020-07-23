import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class BoardService{
  Firestore _firestore = Firestore.instance;
  String categories = "Categories";
  String users = "Users";

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

}
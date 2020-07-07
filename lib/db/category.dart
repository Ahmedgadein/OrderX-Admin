import 'package:orderxadmin/db/generic_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
class CategoryService extends Service{
  String Product_Collection = "Categories";

  @override
  void add(String name) {
    Firestore _firestore = Firestore.instance;
    _firestore.collection(Product_Collection).document(Uuid().v4()).setData({"category_name": name});
  }
}
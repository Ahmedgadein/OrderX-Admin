import 'file:///C:/Users/Ahmed-Obied/orderx_admin/lib/db/services/generic_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
class CategoryService extends Service{
  Firestore _firestore = Firestore.instance;
  String Category_Collection = "Categories";

  @override
  void add(String name) {
    _firestore.collection(Category_Collection).document(Uuid().v4()).setData({"category_name": name});
  }

  Future<List> getCategories(){
    return _firestore.collection(Category_Collection).getDocuments().then((snap) {
      return snap.documents;
    });
  }
}
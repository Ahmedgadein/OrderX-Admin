import 'package:orderxadmin/db/generic_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
class BrandService extends Service{
  Firestore _firestore = Firestore.instance;
  String Brand_Collection = "Brands";

  @override
  void add(String name) {
    _firestore.collection(Brand_Collection).document(Uuid().v4()).setData({"brand_name": name});
  }

  Future<List> getBrands(){
    return _firestore.collection(Brand_Collection).getDocuments().then((snap){
      return snap.documents;
    });
  }
}
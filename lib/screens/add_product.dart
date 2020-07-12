
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orderxadmin/db/brand.dart';
import 'package:orderxadmin/db/category.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  CategoryService _categoryService = new CategoryService();
  BrandService _brandService = new BrandService();

  List<DropdownMenuItem<String>> categoriesDropDown = <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];

  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];

  String _currentCategory = "placeholder";
  String _currentBrand = "placeholder";

  GlobalKey _key = new GlobalKey();

  TextEditingController _product_controller = TextEditingController();
  TextEditingController _quantity_controller = TextEditingController();

  //Image Files
  final ImagePicker _picker = ImagePicker();
  File image1;
  File image2;
  File image3;

  Color white = Colors.white;
  Color grey = Colors.grey;
  Color black = Colors.black;

  @override
  void initState() {
    setUI();
    print("categories Drop Down: ${categoriesDropDown.length}");
    print("brands Drop Down: ${brandsDropDown.length}");
  }

  void setUI() {
    _getCategories();
    _getBrands();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ===== Appbar ======== ///
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.1,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              color: black,
            )),
        title: Text(
          "Add Product",
          style: TextStyle(color: black),
        ),
      ),

      // ======= Body ======== //
      body: Form(
        key: _key,
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //Image 1
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      onTap: () {
                        _addImage(ImagePicker().getImage(source: ImageSource.gallery), 1);
                      },
                      child: _displaychild(1),
                    ),
                  ),
                ),

                //Image2
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      onTap: () {
                        _addImage(ImagePicker().getImage(source: ImageSource.gallery), 2);
                      },
                      child: _displaychild(2),
                    ),
                  ),
                ),

                //Image 3
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      onTap: () {
                        _addImage(_picker.getImage(source: ImageSource.gallery), 3);
                      },
                      child: _displaychild(3),
                    ),
                  ),
                )
              ],
            ),

            // Product Name
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: _product_controller,
                decoration: InputDecoration(hintText: "Enter Product Name"),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Name Cannot be empty";
                  } else if (value.length > 10) {
                    return "Name Cannot be more than 10 characters";
                  }
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text(
                    "Category",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                DropdownButton(
                  items: categoriesDropDown,
                  value: _currentCategory,
                  onChanged: onCategoryChanged,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text(
                    "Brand",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                DropdownButton(
                  items: brandsDropDown,
                  value: _currentBrand,
                  onChanged: onBrandChanged,
                )
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: _quantity_controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Quantity",
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {},
                      color: Colors.blue,
                      child: Text(
                        "Add Product",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _getCategories() async {
    List<DocumentSnapshot> items = await _categoryService.getCategories();
    setState(() {
      categories = items;
      categoriesDropDown = getCategoriesDropDown();
      _currentCategory = categories[0].data["category_name"];
    });
    print("Brands: ${categories[0]["category_name"]}");
  }

  void _getBrands() async {
    List<DocumentSnapshot> items = await _brandService.getBrands();
    setState(() {
      brands = items;
      brandsDropDown = getBrandsDropDown();
      _currentBrand = brands[0].data["brand_name"];
    });
    print("Brands: ${brands[0]["brand_name"]}");
  }

  List<DropdownMenuItem<String>> getCategoriesDropDown() {
    List<DropdownMenuItem<String>> items = new List();
    for (DocumentSnapshot category in categories) {
      items.add(DropdownMenuItem(
        child: Text(category.data["category_name"]),
        value: category.data["category_name"],
      ));
    }

    return items;
  }

  List<DropdownMenuItem<String>> getBrandsDropDown() {
    List<DropdownMenuItem<String>> items = new List();
    for (DocumentSnapshot brand in brands) {
      items.add(DropdownMenuItem(
        child: Text(brand.data["brand_name"]),
        value: brand.data["brand_name"],
      ));
    }

    return items;
  }

  void onCategoryChanged(String value) {
    setState(() {
      _currentCategory = value;
    });
  }

  void onBrandChanged(String value) {
    setState(() {
      _currentBrand = value;
    });
  }

  void _addImage(Future<PickedFile> image, int postion) async {
    final imageFile = await image;

    switch(postion){
      case 1:
        setState(() {
          image1 = File(imageFile.path);
        });
        break;

      case 2:
        setState(() {
          image2  = File(imageFile.path);
        });
        break;

      case 3:
        setState(() {
          image3 = File(imageFile.path);
        });
        break;
    }
  }

  Widget _displaychild(int positon) {
    switch(positon){
      case 1:
        if(image1 == null){
          return Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Icon(Icons.add),
            ),
          );
        }else if (image1 != null){
          return Image.file(image1, fit: BoxFit.fill, width: double.infinity, );
        }
        break;

      case 2:
        if(image2 == null){
          return Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Icon(Icons.add),
            ),
          );
        }else if (image2 != null){
          return Image.file(image2, fit: BoxFit.fill, width: double.infinity, );
        }
        break;


      case 3:
        if(image3 == null){
          return Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Icon(Icons.add),
            ),
          );
        }else if (image3 != null){
          return Image.file(image3, fit: BoxFit.fill, width: double.infinity, );
        }
        break;
    }
  }
}

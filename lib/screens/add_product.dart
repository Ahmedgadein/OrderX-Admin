import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orderxadmin/widgets/color_selector.dart';
import 'package:orderxadmin/widgets/size_selector.dart';
import 'file:///C:/Users/Ahmed-Obied/orderx_admin/lib/db/services/brand.dart';
import 'file:///C:/Users/Ahmed-Obied/orderx_admin/lib/db/services/category.dart';
import 'file:///C:/Users/Ahmed-Obied/orderx_admin/lib/db/services/product.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  CategoryService _categoryService = new CategoryService();
  BrandService _brandService = new BrandService();
  ProductService _productService = ProductService();

  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];

  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];

  String _currentCategory = "placeholder";
  String _currentBrand = "placeholder";

  GlobalKey<FormState> _key = new GlobalKey<FormState>();

  TextEditingController _product_controller = TextEditingController();
  TextEditingController _quantity_controller = TextEditingController();
  TextEditingController _price_controller = TextEditingController();
  TextEditingController _old_price_controller = TextEditingController();
  TextEditingController _details_controller = TextEditingController();

  List<String> selectedColors = <String>[];
  List<String> selectedSizes = <String>[];

  bool isFeatured = false;
  bool onSale = false;
  bool isNew = true;

  //Image Files
  final ImagePicker _picker = ImagePicker();
  File image1;
  File image2;
  File image3;

  bool isLoading = false;

  Color white = Colors.white;
  Color grey = Colors.grey;
  Color black = Colors.black;

  @override
  void initState() {
    super.initState();
    setUI();
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
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
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
                              _addImage(
                                  ImagePicker()
                                      .getImage(source: ImageSource.gallery),
                                  1);
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
                              _addImage(
                                  ImagePicker()
                                      .getImage(source: ImageSource.gallery),
                                  2);
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
                              _addImage(
                                  _picker.getImage(source: ImageSource.gallery),
                                  3);
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
                      decoration:
                          InputDecoration(hintText: "Enter Product Name"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Name Cannot be empty";
                        } else if (value.length > 10) {
                          return "Name Cannot be more than 10 characters";
                        }
                        return null;
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: <Widget>[
                              Text("Featured"),
                              Switch(
                                value: isFeatured,
                                onChanged: onFeaturedChanged,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: <Widget>[
                              Text("New"),
                              Switch(
                                value: isNew,
                                onChanged: onNewChanged,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: <Widget>[
                              Text("On Sale"),
                              Switch(
                                value: onSale,
                                onChanged: onSaleChanged,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Expanded(
                              child: MaterialButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) => ColorSelector(selectedColors));
                                },
                                color: Colors.blue[900],
                                child: Text(
                                  "Select Colors",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Expanded(
                              child: MaterialButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) => SizeSelector(selectedSizes));
                                },
                                color: Colors.blue[900],
                                child: Text(
                                  "Select Sizes",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ]),
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

                  onSale == true
                      ? Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Old Price cannot be empty";
                                    }
                                    return null;
                                  },
                                  controller: _old_price_controller,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      labelText: "Old Price",
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 1)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                              color: Colors.blue[800]))),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Price cannot be empty";
                                    }
                                    return null;
                                  },
                                  controller: _price_controller,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      labelText: "Price",
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 1)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                              color: Colors.blue[800]))),
                                ),
                              ),
                            )
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Price cannot be empty";
                              }
                              return null;
                            },
                            controller: _price_controller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "Price",
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.blue[800]))),
                          ),
                        ),

                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Quantity cannot be empty";
                        }
                        return null;
                      },
                      controller: _quantity_controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Quantity",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.blue[800]))),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Details cannot be empty";
                        }
                        return null;
                      },
                      controller: _details_controller,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                          labelText: "Product Details",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.blue[800]))),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: MaterialButton(
                            onPressed: () {
                              validateAndUpload();
                            },
                            color: Colors.blue,
                            child: Text(
                              "Add Product",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
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

  void _addImage(Future<PickedFile> image, int position) async {
    final imageFile = await image;

    switch (position) {
      case 1:
        setState(() {
          image1 = File(imageFile.path);
        });
        break;

      case 2:
        setState(() {
          image2 = File(imageFile.path);
        });
        break;

      case 3:
        setState(() {
          image3 = File(imageFile.path);
        });
        break;
    }
  }

  Widget _displaychild(int position) {
    switch (position) {
      case 1:
        if (image1 == null) {
          return Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Icon(Icons.add),
            ),
          );
        } else if (image1 != null) {
          return Image.file(
            image1,
            fit: BoxFit.fill,
            width: double.infinity,
          );
        }
        break;

      case 2:
        if (image2 == null) {
          return Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Icon(Icons.add),
            ),
          );
        } else if (image2 != null) {
          return Image.file(
            image2,
            fit: BoxFit.fill,
            width: double.infinity,
          );
        }
        break;

      case 3:
        if (image3 == null) {
          return Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Icon(Icons.add),
            ),
          );
        } else if (image3 != null) {
          return Image.file(
            image3,
            fit: BoxFit.fill,
            width: double.infinity,
          );
        }
        break;
    }
  }

  void validateAndUpload() async {
    if (_key.currentState.validate()) {
      if (image1 != null &&
          image1 != null &&
          image1 != null &&
          _quantity_controller.text != null &&
          _product_controller.text != null && _details_controller.text != null) {


        String image1Url;
        String image2Url;
        String image3Url;

        final _storage = FirebaseStorage.instance.ref();

        //Images file names
        final String pic1 =
            "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
        final String pic2 =
            "2${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
        final String pic3 =
            "3${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";

        setState(() {
          isLoading = true;
        });
        StorageUploadTask task1 = _storage.child(pic1).putFile(image1);
        StorageUploadTask task2 = _storage.child(pic2).putFile(image2);
        StorageUploadTask task3 = _storage.child(pic3).putFile(image3);

        StorageTaskSnapshot snapshot1 = await task1.onComplete;
        image1Url = await snapshot1.ref.getDownloadURL();

        StorageTaskSnapshot snapshot2 = await task2.onComplete;
        image2Url = await snapshot2.ref.getDownloadURL();

        StorageTaskSnapshot snapshot3 = await task3.onComplete;
        image3Url = await snapshot3.ref.getDownloadURL();

        _productService.uploadProduct({
          "product_name": _product_controller.text,
          "category": _currentCategory,
          "brand": _currentBrand,
          "quantity": _quantity_controller.text,
          "onSale": onSale,
          "featured": isFeatured,
          "new": isNew,
          "price": _price_controller.text,
          "old_price": _old_price_controller.text,
          "image1": image1Url,
          "image2": image2Url,
          "image3": image3Url,
          "details": _details_controller.text,
          "sizes": getSizesMap(),
          "colors": getColorsMap()

        });

        _key.currentState.reset();
        setState(() => isLoading = false);
        Fluttertoast.showToast(msg: "Product added successfully");
      }
    }
  }

  Map<String, dynamic> getSizesMap(){
    Map<String,String> result = Map<String,String>();

    for(int i = 0; i < selectedSizes.length; i++){
      result["size" + i.toString()] = selectedSizes[i];
    }

    return result;
  }

  Map<String, dynamic> getColorsMap(){
    Map<String,String> result = Map<String,String>();

    for(int i = 0; i < selectedColors.length; i++){
      result["color" + i.toString()] = selectedColors[i];
    }

    return result;
  }

  void onFeaturedChanged(bool value) {
    setState(() => isFeatured = value);
  }

  void onSaleChanged(bool value) {
    setState(() => onSale = value);
  }

  void onNewChanged(bool value) {
    setState(() => isNew = value);
  }
}

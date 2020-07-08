import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orderxadmin/db/brand.dart';
import 'package:orderxadmin/db/category.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  CategoryService _categoryService = new CategoryService();
  BrandService _brandService = new BrandService();

  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];

  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];

  String _currentCategory = "placeholder";
  String _currentBrand = "placeholder";

  GlobalKey _key = new GlobalKey();
  TextEditingController _product_controller = TextEditingController();
  TextEditingController _quantity_controller = TextEditingController();

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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      onTap: () {},
                      child: Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Icon(Icons.add),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      onTap: () {},
                      child: Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Icon(Icons.add),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      onTap: () {},
                      child: Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Icon(Icons.add),
                        ),
                      ),
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
                      child: Text("Add Product", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
}

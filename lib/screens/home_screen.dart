import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orderxadmin/db/category.dart';
import 'package:orderxadmin/db/generic_service.dart';
import 'package:orderxadmin/db/brand.dart';
import 'package:orderxadmin/screens/add_product.dart';

enum Page { dashboard, manage }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Page _selectedPage = Page.dashboard;
  Color active = Colors.blue;
  Color inactive = Colors.grey;

  BrandService _brandService = new BrandService();
  CategoryService _categoryService = new CategoryService();

  TextEditingController _category_controller = new TextEditingController();
  TextEditingController _brand_controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          children: <Widget>[
            Expanded(
                child: FlatButton.icon(
                    onPressed: () {
                      setState(() {
                        _selectedPage = Page.dashboard;
                      });
                    },
                    icon: Icon(
                      Icons.dashboard,
                      color:
                          _selectedPage == Page.dashboard ? active : inactive,
                    ),
                    label: Text(
                      "Dashboard",
                      style: TextStyle(color: Colors.blueGrey),
                    ))),
            Expanded(
              child: FlatButton.icon(
                  onPressed: () {
                    setState(() {
                      _selectedPage = Page.manage;
                    });
                  },
                  icon: Icon(Icons.sort,
                      color: _selectedPage == Page.manage ? active : inactive),
                  label: Text(
                    "Manage",
                    style: TextStyle(color: Colors.blueGrey),
                  )),
            )
          ],
        ),
      ),
      body: _loadScreen(),
    );
  }

  Widget _loadScreen() {
    switch (_selectedPage) {
      case Page.dashboard:
        // =============== Dashboard ===================== //
        return Column(
          children: <Widget>[
            //Revenue
            Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Center(
                  child: Text(
                    "Revenue",
                    style: TextStyle(fontSize: 20.0, color: Colors.grey),
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        "\$",
                        style:
                            TextStyle(fontSize: 28.0, color: Colors.green[700]),
                      ),
                    ),
                    Text(
                      "22403",
                      style:
                          TextStyle(fontSize: 28.0, color: Colors.green[700], fontWeight: FontWeight.bold),
                    ),
                  ],
                )),

            //=== Cards ===//
            Flexible(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: <Widget>[
                  //Users
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 80,
                      width: 80,
                      child: Card(
                        elevation: 5.0,
                        child: GridTile(
                          header: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.people),
                              label: Text(
                                "Users",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              )),
                          child: Center(
                              child: Text(
                            "12",
                            style: TextStyle(fontSize: 60, color: Colors.blue),
                          )),
                        ),
                      ),
                    ),
                  ),

                  //Categories
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 80,
                      width: 80,
                      child: Card(
                        elevation: 5.0,
                        child: GridTile(
                          header: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.category),
                              label: Text(
                                "Categories",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              )),
                          child: Center(
                              child: Text(
                                "3",
                                style: TextStyle(fontSize: 60, color: Colors.blue),
                              )),
                        ),
                      ),
                    ),
                  ),

                  //Products
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 80,
                      width: 80,
                      child: Card(
                        elevation: 5.0,
                        child: GridTile(
                          header: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.toll),
                              label: Text(
                                "Products",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              )),
                          child: Center(
                              child: Text(
                                "12",
                                style: TextStyle(fontSize: 60, color: Colors.blue),
                              )),
                        ),
                      ),
                    ),
                  ),

                  //Sold
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 80,
                      width: 80,
                      child: Card(
                        elevation: 5.0,
                        child: GridTile(
                          header: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.shopping_basket),
                              label: Text(
                                "Sold",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              )),
                          child: Center(
                              child: Text(
                                "12",
                                style: TextStyle(fontSize: 60, color: Colors.blue),
                              )),
                        ),
                      ),
                    ),
                  ),

                  //Orders
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 80,
                      width: 80,
                      child: Card(
                        elevation: 5.0,
                        child: GridTile(
                          header: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.shopping_cart),
                              label: Text(
                                "Orders",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              )),
                          child: Center(
                              child: Text(
                                "12",
                                style: TextStyle(fontSize: 60, color: Colors.blue),
                              )),
                        ),
                      ),
                    ),
                  ),

                  //Return
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 80,
                      width: 80,
                      child: Card(
                        elevation: 5.0,
                        child: GridTile(
                          header: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.clear),
                              label: Text(
                                "Return",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              )),
                          child: Center(
                              child: Text(
                                "12",
                                style: TextStyle(fontSize: 60, color: Colors.blue),
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
        break;

      case Page.manage:
        // =============== Manage ===================== //
        return ListView(
          children: <Widget>[
            //Add Product
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductScreen()));
                },
                leading: Icon(Icons.add),
                title: Text("Add Product"),
              ),
            ),
            //Products List
            Card(
              child: ListTile(
                onTap: () {},
                leading: Icon(Icons.format_list_bulleted),
                title: Text("Products List"),
              ),
            ),

            Divider(),

            //Add Category
            Card(
              child: ListTile(
                onTap: () {
                  _createDialog("Category", _category_controller, _categoryService);
                },
                leading: Icon(Icons.add_circle_outline),
                title: Text("Add Category"),
              ),
            ),
            //Categories List
            Card(
              child: ListTile(
                onTap: () {},
                leading: Icon(Icons.category),
                title: Text("Category List"),
              ),
            ),

            Divider(),

            //Add Brand
            Card(
              child: ListTile(
                onTap: () {
                  _createDialog("Product",_brand_controller, _brandService);
                },
                leading: Icon(Icons.add_circle),
                title: Text("Add Brand"),
              ),
            ),
            //Brands List
            Card(
              child: ListTile(
                onTap: () {},
                leading: Icon(Icons.library_books),
                title: Text("Brands List"),
              ),
            )
          ],
        );
        break;

      default:
        return Container();
        break;
    }
  }
  void _createDialog(String label, TextEditingController controller, Service service){
    var alert = AlertDialog(
      content: TextFormField(
        controller: controller,
        validator: (value){
          if(value.isEmpty)
            return "Cannot be empty";
        },
        decoration: InputDecoration(
            hintText: "Enter ${label}"
        ),

      ),
      actions: <Widget>[
        FlatButton(onPressed: (){
          if (controller.text != null){
            service.add(controller.text);
            Fluttertoast.showToast(msg: "created ${label} Successfully");
            Navigator.pop(context);
          }else{
            Fluttertoast.showToast(msg: "${label} Cannot be empty");
          }
        }, child: Text("ADD"),),

        FlatButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("CANCEL"),)
      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }
}


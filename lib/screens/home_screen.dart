import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orderxadmin/db/services/dashboard_service.dart';
import 'file:///C:/Users/Ahmed-Obied/orderx_admin/lib/db/services/brand.dart';
import 'file:///C:/Users/Ahmed-Obied/orderx_admin/lib/db/services/category.dart';
import 'file:///C:/Users/Ahmed-Obied/orderx_admin/lib/db/services/generic_service.dart';
import 'package:orderxadmin/screens/add_product.dart';

// Pages
enum Page { dashboard, manage }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Page _selectedPage = Page.dashboard;
  Color active = Colors.blue;
  Color inactive = Colors.grey;

  BoardService _service = BoardService();
  BrandService _brandService = new BrandService();
  CategoryService _categoryService = new CategoryService();

  TextEditingController _category_controller = new TextEditingController();
  TextEditingController _brand_controller = new TextEditingController();

  String categories;
  String users;
  String products;
  String brands;

  @override
  void initState()  {
    super.initState();
    manageSignIn();
    getData();
  }

  Future getCategories() async {
    setState(() {
    });
  }

  Future getUsers() async {
    setState(() {
    });
  }

  manageSignIn() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user == null){
      await FirebaseAuth.instance.signInAnonymously().then((value) async{
        Fluttertoast.showToast(msg: "SignedIn");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          children: <Widget>[
            //Dashboard tab
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

            //Manage tab
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
                      style: TextStyle(
                          fontSize: 28.0,
                          color: Colors.green[700],
                          fontWeight: FontWeight.bold),
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
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              )),
                          child: Center(
                              child: Text(
                            users == null ? 0.toString() : users,
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
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              )),
                          child: Center(
                              child: Text(
                            categories == null ? 0.toString() : categories,
                            style: TextStyle(fontSize: 60, color: Colors.blue),
                          )),
                        ),
                      ),
                    ),
                  ),

                  //Brands
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
                                "Brands",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              )),
                          child: Center(
                              child: Text(
                                brands == null ? 0.toString(): brands,
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
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              )),
                          child: Center(
                              child: Text(
                            products == null ? 0.toString() : products,
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
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
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
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              )),
                          child: Center(
                              child: Text(
                            "1",
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
        return getMangeScreen();
        break;

      default:
        //Placeholder, doesn't actually happen
        return Container();
        break;
    }
  }

  ListView getMangeScreen() {
    return ListView(
        children: <Widget>[
          //Add Product
          Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddProductScreen()));
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
                _createDialog(
                    "Category", _category_controller, _categoryService);
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
                _createDialog("Product", _brand_controller, _brandService);
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
  }

  void _createDialog(
      String label, TextEditingController controller, Service service) {
    var alert = AlertDialog(
      content: TextFormField(
        controller: controller,
        validator: (value) {
          if (value.isEmpty) {
            return "Cannot be empty";
          }
          return null;
        },
        decoration: InputDecoration(hintText: "Enter ${label}"),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("ADD"),
          onPressed: () {
            if (controller.text != null) {
              service.add(controller.text);
              Fluttertoast.showToast(msg: "created ${label} Successfully");
              Navigator.pop(context);
            } else {
              Navigator.pop(context);
              Fluttertoast.showToast(msg: "${label} Cannot be empty");
            }
          },
        ),
        FlatButton(
          child: Text("CANCEL"),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }

  void getData() async {
    users = await _service.getUsersCount();
    categories = await _service.getCategoriesCount();
    products = await _service.getProductsCount();
    brands = await _service.getBrandsCount();
    setState(() {
    });
  }
}

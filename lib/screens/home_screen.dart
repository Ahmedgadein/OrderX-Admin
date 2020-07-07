import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Page { dashboard, manage }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Page _selectedPage = Page.dashboard;
  Color active = Colors.deepPurple;
  Color inactive = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
                        style: TextStyle(color: Colors.white),
                      ))),
              Expanded(
                child: FlatButton.icon(
                    onPressed: () {
                      setState(() {
                        _selectedPage = Page.manage;
                      });
                    },
                    icon: Icon(Icons.sort,
                        color:
                            _selectedPage == Page.manage ? active : inactive),
                    label: Text(
                      "Manage",
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
        ),

      body: _loadScreen(),
    );
  }

 Widget _loadScreen() {
    switch(_selectedPage){
      case Page.dashboard:

        // =============== Dashboard ===================== //
        return Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top:10.0),
                child: Center(
                  child: Text(
                    "Revenue",
                    style: TextStyle(fontSize: 20.0, color: Colors.grey),
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(top:10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right:8.0),
                      child: Text("\$", style: TextStyle(fontSize: 28.0, color: Colors.green[700]),),
                    ),
                    Text(
                      "22403",
                      style: TextStyle(fontSize: 28.0, color: Colors.green[700]),
                    ),
                  ],
                )),
            Flexible(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 80,
                      width: 80,
                      child: Card(
                        elevation: 5.0,
                        child: GridTile(
                          header: FlatButton.icon(onPressed: null, icon: Icon(Icons.person), label: Text("Users")),
                          child: Center(child: Text("12", style: TextStyle(fontSize: 60, color: Colors.blue),)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 80,
                      width: 80,
                      child: Card(
                        elevation: 5.0,
                        child: GridTile(
                          header: FlatButton.icon(onPressed: null, icon: Icon(Icons.person), label: Text("Users")),
                          child: Center(child: Text("First")),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 80,
                      width: 80,
                      child: Card(
                        elevation: 5.0,
                        child: GridTile(
                          header: FlatButton.icon(onPressed: null, icon: Icon(Icons.person), label: Text("Users")),
                          child: Center(child: Text("First")),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 80,
                      width: 80,
                      child: Card(
                        elevation: 5.0,
                        child: GridTile(
                          header: FlatButton.icon(onPressed: null, icon: Icon(Icons.person), label: Text("Users")),
                          child: Center(child: Text("First")),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 80,
                      width: 80,
                      child: Card(
                        elevation: 5.0,
                        child: GridTile(
                          header: FlatButton.icon(onPressed: null, icon: Icon(Icons.person), label: Text("Users")),
                          child: Center(child: Text("First")),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 80,
                      width: 80,
                      child: Card(
                        elevation: 5.0,
                        child: GridTile(
                          header: FlatButton.icon(onPressed: null, icon: Icon(Icons.person), label: Text("Users")),
                          child: Center(child: Text("First")),
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
            Card(
              child: ListTile(
                onTap: (){},
                leading: Icon(Icons.add),
                title: Text("Add Product"),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){},
                leading: Icon(Icons.format_list_bulleted),
                title: Text("Products List"),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){},
                leading: Icon(Icons.add_circle_outline),
                title: Text("Add Category"),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){},
                leading: Icon(Icons.category),
                title: Text("Category List"),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){},
                leading: Icon(Icons.add_circle),
                title: Text("Add Brand"),
              ),
            ),
            Card(
              child: ListTile(
                onTap: (){},
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
}

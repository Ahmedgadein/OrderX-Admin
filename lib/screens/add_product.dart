import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  Color white = Colors.white;
  Color grey = Colors.grey;
  Color black = Colors.black;

  GlobalKey _key = new GlobalKey();
  TextEditingController _product_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ===== Appbar ======== ///
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.1,
        leading: InkWell(
          onTap: (){Navigator.pop(context);},
            child: Icon(Icons.close, color: black,)),
        title: Text("Add Product", style: TextStyle(color: black),),
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
                      onTap: (){},
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
                      onTap: (){},
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
                      onTap: (){},
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
                decoration: InputDecoration(
                  hintText: "Enter Product Name"
                ),
                validator: (value){
                  if (value.isEmpty){
                    return "Name Cannot be empty";
                  }else if (value.length > 10){
                    return "Name Cannot be more than 10 characters";
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

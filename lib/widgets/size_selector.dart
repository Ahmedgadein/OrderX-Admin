import 'package:flutter/material.dart';

class ProductSize {
  String _label;

  String get label => _label;

  ProductSize(String label) {
    _label = label;
  }
}

class SizeSelector extends StatefulWidget {
  List<String> _selectedSizes = List<String>();

  SizeSelector(List<String> selectedSizes){
    _selectedSizes = selectedSizes;
  }
  List<ProductSize> _colors = [
    ProductSize("S"),
    ProductSize("M"),
    ProductSize("L"),
    ProductSize("XL"),
    ProductSize("XXL"),
    ProductSize("28"),
    ProductSize("30"),
    ProductSize("32"),
    ProductSize("34"),
    ProductSize("36"),
    ProductSize("40"),
    ProductSize("42"),
    ProductSize("43"),
    ProductSize("44"),
    ProductSize("45"),
    ProductSize("46"),
  ];


  @override
  _SizeSelectorState createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Select available Sizes"),
      actions: <Widget>[
        MaterialButton(
          onPressed: (){Navigator.of(context).pop();},
          color: Colors.blue,
          child: Text("OK", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),),
        )
      ],
      content: Wrap(
        children: widget._colors
            .map((e) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: new FilterChip(
            label: Text(e.label),
            selected: widget._selectedSizes.contains(e.label),
            onSelected: (bool value) {
              setState(() {
                if (value) {
                  widget._selectedSizes.add(e.label);
                } else {
                  widget._selectedSizes
                      .removeWhere((element) => element == e.label);
                }
              });

              print(widget._selectedSizes);
            },
          ),
        ))
            .toList(),
      ),
    );
  }
}

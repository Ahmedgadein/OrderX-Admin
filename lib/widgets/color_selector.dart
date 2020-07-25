import 'package:flutter/material.dart';

class ProductColor {
  String _label;

  String get label => _label;

  ProductColor(String label) {
    _label = label;
  }
}

class ColorSelector extends StatefulWidget {
  List<String> _selectedColors;
  ColorSelector(List<String> selectedColors){
    _selectedColors = selectedColors;
  }

  List<ProductColor> _colors = [
    ProductColor("Red"),
    ProductColor("Blue"),
    ProductColor("Orange"),
    ProductColor("Black"),
    ProductColor("Purple"),
    ProductColor("Yellow"),
    ProductColor("Grey"),
    ProductColor("Green"),
    ProductColor("Pink"),
  ];



  @override
  _ColorSelectorState createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Select available colors"),
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
                    selected: widget._selectedColors.contains(e.label),
                    onSelected: (bool value) {
                      setState(() {
                        if (value) {
                          widget._selectedColors.add(e.label);
                        } else {
                          widget._selectedColors
                              .removeWhere((element) => element == e.label);
                        }
                      });

                    },
                  ),
                ))
            .toList(),
      ),
    );
  }
}

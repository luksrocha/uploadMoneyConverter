import 'package:flutter/material.dart';

class TextFieldBuilder extends StatelessWidget {
  String label;
  String prefix;
  TextEditingController c;
  Function f;
  
  TextFieldBuilder({
    @required this.label,
    @required this.prefix,
    @required this.c,
    @required this.f
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: c,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color:Colors.amber),
        border:OutlineInputBorder(),
        prefixText: prefix,
      ),
      style:TextStyle(
        color:Colors.amber,
        fontSize:25
      ),
      onChanged: f,
      keyboardType: TextInputType.number,
    );
  }
}
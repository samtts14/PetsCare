import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  CustomTextField({
    @required this.labelText 
  });
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (String str){
        setState(() {
          
        });
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        hintText: "nombre",
      ),
    );
  }
}
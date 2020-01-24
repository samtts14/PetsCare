import 'package:app_tesis/screen/login2.dart';
import 'package:flutter/material.dart';
import 'package:app_tesis/screen/menu.dart';


void main(){
  
  runApp(MyApp());

}

class MyApp extends StatelessWidget{
  @override

  Widget build(BuildContext context){
    return new MaterialApp(
      home: Menu(),
      // theme: new ThemeData(
        // primarySwitch: Colors.blue
      // )
    );
  }
}

import 'package:app_tesis/screen/notas.dart';
import 'package:app_tesis/models/user.dart';
import 'package:app_tesis/screen/auth.dart';
import 'package:app_tesis/screen/authenticate/login2.dart';
import 'package:app_tesis/screen/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




void main(){
  
  runApp(MyApp());

}

class MyApp extends StatelessWidget{
  @override

  Widget build(BuildContext context){
    return StreamProvider<User>.value(
      value: AuthService().user,

      child: MaterialApp(
        home: Wrapper(),
        // SaveNote(texto: TextStorage()),
      ),
    );
  }
}

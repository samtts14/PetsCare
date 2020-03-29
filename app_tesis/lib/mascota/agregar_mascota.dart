import 'package:app_tesis/mascota/settings_form.dart';
import 'package:flutter/material.dart';
import 'package:app_tesis/shared/constant.dart';

class AgregarMascota extends StatefulWidget {
  @override
  _AgregarMascotaState createState() => _AgregarMascotaState();
}

class _AgregarMascotaState extends State<AgregarMascota> {
  
  final _formKey = GlobalKey<FormState>();
  MediaQueryData queryData;
  
  final List<String> sexs = ['M', 'F'];
  final List<String> species = ['Bird', 'Cat', 'Dog'];
  final List<String> breeds = ['Husky', 'Chow-Chow', 'Bulldog'];

  //form values
  String _currentName;
  String _currentBreed;
  String _currentSpecie;
  String _currentSex;
  String _currentAge;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text( "Agregar mascota"),
        backgroundColor: Colors.green[200], //Color del bacground del titulo
      ),
      body: SettingsForm(),
    );
  }
}
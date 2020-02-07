import 'package:flutter/material.dart';
import 'package:app_tesis/shared/constant.dart';

class AgregarMascota extends StatefulWidget {
  @override
  _AgregarMascotaState createState() => _AgregarMascotaState();
}

class _AgregarMascotaState extends State<AgregarMascota> {
  
  final _formKey = GlobalKey<FormState>();
  MediaQueryData queryData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text( "Agregar mascota"),
        backgroundColor: Colors.green[200], //Color del bacground del titulo
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        icon: const Icon(Icons.add),
        label: const Text('Agregar'),
        backgroundColor: Colors.green[200],
        onPressed: () {}
      ),
      floatingActionButtonLocation: 
        FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        child:Container(height: 60, color: Colors.green[200]),
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
      ),
      
      body: Row(
        children: <Widget>[
          
          Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height /9.5,
            width: MediaQuery.of(context).size.width /2,
            //color: Colors.blue,
            child: TextFormField(decoration: textInputDecoration.copyWith(hintText: 'Nombre'),
            ),

          ),
          Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height /9.5,
            width: MediaQuery.of(context).size.width /2,
            //color: Colors.purpleAccent,
            child: TextField(decoration: textInputDecoration.copyWith(hintText: 'prueba'),),
            ),
        ],
        
        
      ),
    );
  }
}
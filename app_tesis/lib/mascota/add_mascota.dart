import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AddMascota extends StatefulWidget {
  @override
  _AddMascotaState createState() => _AddMascotaState();
}

class _AddMascotaState extends State<AddMascota> {
  
  final GlobalKey<FormState> _formkeyValue = new GlobalKey<FormState>();
  DateTime _dueDate = new DateTime.now();
  String _dateText = '';

  // final FirebaseAuth _firebaseAuth;

  List<String> _tipoDeMascota = <String>[
    'Perro',
    'Gato',
    'Ave',
  ];
  List<String> _razaDeMascota = <String>[
    'Chow-Chow',
    'Chihuahua',
    'Husky',
  ];

  String name = '';
  String especie = 'Perro';
  String raza = 'Chow-Chow';
  String edad = '';
  String sexo = '';
  String owner = '';

  Future<Null> _razasPorMascota(String especie) async{
    switch( especie){
      case 'Perro': { _razaDeMascota = <String>[
                      'Chow-Chow',
                      'Chihuahua',
                      'Husky',];}
      break;
      case 'Gato': {_razaDeMascota = <String>[
                      'British Shorthair',
                      'Coon De Maine',
                      'Persas Doll',];}
      break;
      case 'Ave': {_razaDeMascota = <String>[
                      'Cacatua',
                      'Loro',
                      'Perico',];}
      break;
      }
    }

  Future<Null> _selectDueDate(BuildContext context) async{
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2060)
    );

    if(picked != null){
      setState(() {
        _dueDate = picked;
        _dateText = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }


  void _addData(){
    Firestore.instance.runTransaction((Transaction transssaction) async{
      CollectionReference reference = Firestore.instance.collection('pets');
      await reference.add({
        "owner's email" : owner,
        "name" : name,
        "especie" : especie,
        "raza" : raza,
        
        "sexo" : sexo,
        "adquisicion" : _dateText
      });
    });
    Navigator.pop(context);
  }

  @override
    void initState(){
      super.initState();
      _dateText = '${_dueDate.day}/${_dueDate.month}/${_dueDate.year}';
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.white
          ),
          onPressed: () {},
        ),
        title: Container(
          alignment: Alignment.centerLeft,
          child: Text("Datos de Mascota", style: TextStyle(color: Colors.white),),
        ),
        
      ),
      
      body: Form(
        key: _formkeyValue,
        autovalidate: true,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(
                  Icons.create,
                  color: Colors.teal
                ),
                hintText: 'Nombre de Mascota',
                labelText: 'Nombre'
              ),

            ),

            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.pets,
                size: 25.0,
                color: Colors.brown,),
                
                DropdownButton<String>(
                  value: especie,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      especie = newValue;
                      _razasPorMascota(especie);
                    });
                  },
                  
                  items: <String>['Perro','Ave', 'Gato', ]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              ],
            ),
            
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.pets,
                size: 25.0,
                color: Colors.brown,),
                DropdownButton<String>(
                  value: raza,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      raza = newValue;
                    });
                  },
                  items: _razaDeMascota
                      .map<DropdownMenuItem<String>>((String value){
                      return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              ],
            ),
          ],
        ),
      ),
    );
      
     // abajo esta los dos iconos el de agregar la informacion al collection 
      // y el de volver a la pantalla de mascota
      
      // final currentUser = await FirebaseAuth.instance.currentUser();
      // owner = currentUser.email.toString();
      // _addData()
  }
}
     
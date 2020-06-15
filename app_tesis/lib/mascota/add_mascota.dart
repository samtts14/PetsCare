import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AddMascota extends StatefulWidget {
  @override
  _AddMascotaState createState() => _AddMascotaState();
}

class _AddMascotaState extends State<AddMascota> {
  
  DateTime _dueDate = new DateTime.now();
  String _dateText = '';

  // final FirebaseAuth _firebaseAuth;

  String name = '';
  String especie = '';
  String raza = '';
  String edad = '';
  String sexo = '';
  String owner = '';

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
    return new Material(
      child: Column(
        children: <Widget>[
          Container(
            height: 100.0,
            width:double.infinity,
            decoration: BoxDecoration(
              color: Colors.purple
            ),
            child: Column(
              children: <Widget>[
              Text('Mascota', style: new TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                letterSpacing: 2.0,
                fontFamily: "Pacifico" ),
              ),
            ],
          )
        ),
        new Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (String str){
              setState(() {
                name = str;
              });
            },
            decoration: new InputDecoration(
              icon: Icon(Icons.dashboard),
              hintText: 'Nombre de Mascota',
              border: InputBorder.none
            )
          ),
        ),
        new Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (String str){
              setState(() {
                especie = str;
              });
            },
            decoration: new InputDecoration(
              icon: Icon(Icons.dashboard),
              hintText: 'Especie',
              border: InputBorder.none
            )
          ),
        ),  
        new Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (String str){
              setState(() {
                raza = str;
              });
            },
            decoration: new InputDecoration(
              icon: Icon(Icons.dashboard),
              hintText: 'Raza',
              border: InputBorder.none
            )
          ),
        ),
        new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Row(
            children: <Widget>[
              new Icon(Icons.date_range),
              new Expanded(child: Text('Fecha de nacimiento o Adquisicion', style: new TextStyle(fontSize: 16.0)),),
              new FlatButton(
                onPressed: () => _selectDueDate(context) ,
                child: Text(_dateText, style: new TextStyle(fontSize: 16.0))
              )
            ],
          )
        ),
        
        
        new Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (String str){
              setState(() {
                sexo = str;
              });
            },
            decoration: new InputDecoration(
              icon: Icon(Icons.dashboard),
              hintText: 'Sexo',
              border: InputBorder.none
            )
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.check, size: 40.0),
                onPressed: () async{
                  final currentUser = await FirebaseAuth.instance.currentUser();
                  owner = currentUser.email.toString();
                  _addData();
                },
              ),
              IconButton(
                icon: Icon(Icons.close, size: 40.0),
                onPressed: (){
                  Navigator.pop(context);
                },
              )
              
            ],
          )
          
          )
        ]
      )
      
    );
  }
}
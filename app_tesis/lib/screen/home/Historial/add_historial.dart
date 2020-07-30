import 'package:petscare/Servicios/firestore_historial.dart';
import 'package:petscare/Servicios/historial_ser.dart';
import 'package:petscare/widgetsCitas/custom_date_time_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddHistorialPage extends StatefulWidget {
  final HistorialServ historial;
  final String email;

  const AddHistorialPage({Key key, this.historial, this.email}) : super(key: key);
  @override
  _AddHistorialPageState createState() => _AddHistorialPageState(); 
}

class _AddHistorialPageState extends State<AddHistorialPage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  FocusNode _descriptionNode;
  DateTime _dueDate = new DateTime.now();
    String _dateText = 'Elegir fecha';
  String _selectedDate = 'Elegir fecha';
  String mascotaId = "";
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  var mascota;
  
  @override
  void initState() {
    super.initState();
    _titleController =  TextEditingController(text: isEditMote ?
    widget.historial.titulo: "");
    _descriptionController = TextEditingController(text: isEditMote ?
    widget.historial.descripcion: "");
    _descriptionNode = FocusNode();
    
  }

  get isEditMote => widget.historial != null;
  Future _pickDate() async{
    DateTime datepick = await showDatePicker(
      context: context, 
      initialDate: _dueDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2060),
      builder: (BuildContext context, Widget child) {
            return Theme(
              data: ThemeData.from(colorScheme: 
                    ColorScheme.light(
                    primary: Colors.brown[600],
                    onPrimary: Colors.white,
                    surface: Colors.brown[600],
                    onSurface: Colors.black,
                    background: Colors.white,
                    onBackground: Colors.black
                    ),
               // dialogBackgroundColor:Colors.white,
              ),
              child: child,
            );
          },
      
    );

    if(datepick != null ) setState(() {
      _selectedDate = datepick.toString();
      _dateText = '${datepick.day}/${datepick.month}/${datepick.year}';
    });
  }
  Future<String> get user async{
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser.email.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMote ? 'Editar nota' : 'Añadir notas'),
         backgroundColor: Colors.brown[600],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                textInputAction: TextInputAction.next,
                onEditingComplete: (){
                  FocusScope.of(context).requestFocus(_descriptionNode);
                },
                controller: _titleController,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "El titulo no puede estar vacío";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Titulo",
                  border: OutlineInputBorder()
                ),
              ),
              CustomDateTimePicker(
              icon: Icons.date_range,
              onPressed: _pickDate,
              value: _dateText
            ),
                
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection("pets").where("owner", isEqualTo: widget.email).snapshots(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  Text("Cargando");
                }
                else{
                  List<DropdownMenuItem> mascotas=[];
                  for(int i = 0; i < snapshot.data.documents.length; i++){
                    DocumentSnapshot snap = snapshot.data.documents[i];
                    mascotas.add(
                      DropdownMenuItem(
                        child: Text(
                          snap.data["name"],
                          style: TextStyle(color: Colors.black),
                        ),
                        value: "${snap.data["name"]}",
                      )
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.pets, size: 25.0,color: Colors.brown),
                      DropdownButton(
                        items:mascotas,
                        onChanged: (mascotas){
                          final snackBar = SnackBar(
                            content: Text("Selecciono a ${mascotas}",style: TextStyle(color: Colors.cyan)),
                            );
                            
                            Scaffold.of(context).showSnackBar(snackBar);
                            setState(() {
                              mascota = mascotas;
                              print("${widget.email}");
                            });
                        },
                        value: mascota,
                        
                        isExpanded: false,
                        hint: new Text('Selecciona una mascota', style:TextStyle(color: Colors.black))

                      )
                    ],
                  );
                }
              },
            ),
              const SizedBox(height: 10.0),
              TextFormField(
                focusNode: _descriptionNode,
                controller: _descriptionController,
                maxLines: 7,
                decoration: InputDecoration(
                  labelText: "Descripción",
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height:20.0),
              RaisedButton(
                color: Colors.yellow[800],
                textColor: Colors.black,
                child:  Text(isEditMote ? "Actualizar" : "Guardar"),//poner logo de guardar
                shape: RoundedRectangleBorder(// bordes
                borderRadius: new BorderRadius.circular(20),
                   // side: BorderSide(color: Colors.red)
                    ),
                onPressed: () async {
                  final currentUser = await _firebaseAuth.currentUser();
                  String email = currentUser.email.toString();
                  if(_key.currentState.validate()){
                     
                    try {
                      if(isEditMote){
                       HistorialServ historial =  HistorialServ(
                        descripcion: _descriptionController.text,
                        titulo: _titleController.text,
                        owner: email,
                        fecha: _dateText,
                        mascota: mascota,
                        id: widget.historial.id
                      );
                       await FirestoreService().addHistorial(historial);
                      }else{
                       HistorialServ historial =  HistorialServ(
                        descripcion: _descriptionController.text,
                        titulo: _titleController.text,
                        owner: email,
                        fecha: _dateText,
                        mascota: mascota,
                        
                      );
                        await  FirestoreService().addHistorial(historial);
                      }                   
                      Navigator.pop(context);
                    } catch (e) {
                      print(e);
                  }  
                }                          
                },
              ),
            ],
          ) 
        )
      ),
    );
  }
}
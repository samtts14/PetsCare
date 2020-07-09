import 'package:app_tesis/Servicios/firestore_historial.dart';
import 'package:app_tesis/Servicios/historial_ser.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddHistorialPage extends StatefulWidget {
  final HistorialServ historial;
  const AddHistorialPage({Key key, this.historial}) : super(key: key);
  @override
  _AddHistorialPageState createState() => _AddHistorialPageState(); 
}

class _AddHistorialPageState extends State<AddHistorialPage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  FocusNode _descriptionNode;

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
                  if(_key.currentState.validate()){
                     
                    try {
                      if(isEditMote){
                       HistorialServ historial =  HistorialServ(
                        descripcion: _descriptionController.text,
                        titulo: _titleController.text,
                        id: widget.historial.id
                      );
                       await FirestoreService().addHistorial(historial);
                      }else{
                       HistorialServ historial =  HistorialServ(
                        descripcion: _descriptionController.text,
                        titulo: _titleController.text,
                        
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
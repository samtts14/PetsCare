import 'package:petscare/Servicios/firestore_service.dart';
import 'package:petscare/Servicios/note.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddNotePage extends StatefulWidget {
  final Note note;
  const AddNotePage({Key key, this.note}) : super(key: key);
  
  
  @override
  _AddNotePageState createState() => _AddNotePageState(); 
}

class _AddNotePageState extends State<AddNotePage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  FocusNode _descriptionNode;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  
  

  @override
  void initState() {
    super.initState();
    _titleController =  TextEditingController(text: isEditMote ?
    widget.note.title: "");
    _descriptionController = TextEditingController(text: isEditMote ?
    widget.note.description: "");
    _descriptionNode = FocusNode();
    
  }

  get isEditMote => widget.note != null;

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
                  final currentUser = await _firebaseAuth.currentUser();
                  if(_key.currentState.validate()){
                     
                    try {
                      if(isEditMote){
                       Note note =  Note(
                        description: _descriptionController.text,
                        title: _titleController.text,
                        owner: currentUser.email,
                        id: widget.note.id,
                         
                        
                      );
                       await FirestoreService().updateNote(note);
                      }else{
                       Note note =  Note(
                        description: _descriptionController.text,
                        title: _titleController.text,
                        owner: currentUser.email, 
                        
                      );
                        await  FirestoreService().addNote(note);
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
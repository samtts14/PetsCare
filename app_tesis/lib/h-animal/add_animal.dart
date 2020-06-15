import 'package:app_tesis/Servicios/firestore_service_mascotas.dart';
import 'package:app_tesis/Servicios/animal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddAnimalPage extends StatefulWidget {
  final Animal animal;
  const AddAnimalPage({Key key, this.animal}) : super(key: key);
  @override
  _AddAnimalPageState createState() => _AddAnimalPageState(); 
}

class _AddAnimalPageState extends State<AddAnimalPage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _nameController;
  TextEditingController _especie;
  TextEditingController _raza;
  TextEditingController _sexo;
  TextEditingController _owner;
  //DateTime _dateTime;
  FocusNode _descriptionNode;

  @override
  void initState() {
    super.initState();
    _nameController =  TextEditingController(text: isEditMote ?
    widget.animal.name: "");
    _especie = TextEditingController(text: isEditMote ?
    widget.animal.especie: "");
    _descriptionNode = FocusNode();
     _raza =  TextEditingController(text: isEditMote ?
    widget.animal.raza: "");
     _sexo =  TextEditingController(text: isEditMote ?
    widget.animal.sexo: "");
  
  }

  get isEditMote => widget.animal != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMote ? 'Editar Mascota' : 'Añadir mascota'),
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
                controller: _nameController,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "El Nombre no puede estar vacío";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Nombre",
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                focusNode: _descriptionNode,
                controller: _especie,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: "especie",
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
                       Animal animal =  Animal(
                        especie: _especie.text,
                        name: _nameController.text,
                        raza: _raza.text,
                        sexo: _sexo.text,
                       
                       
                        
                        
                        id: widget.animal.id
                      );
                       await FirestoreService().updateAnimal(animal);
                      }else{
                       Animal animal =  Animal(
                        especie: _especie.text,
                        name: _nameController.text,
                        raza: _raza.text,
                        sexo: _sexo.text,
                       
                        
                      );
                        await  FirestoreService().addAnimal(animal);
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
import 'package:app_tesis/Servicios/firestore_service_mascotas.dart';
import 'package:app_tesis/Servicios/animal.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FocusNode _descriptionNode;
  FirebaseUser user;
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
  String sexo = 'M';
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

    DateTime _dueDate = new DateTime.now();
    String _dateText = '';

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

    super.initState();
    _dateText = "${_dueDate.day}/${_dueDate.month}/${_dueDate.year}";
  
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

              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.pets,
                  size: 25.0,
                  color: Colors.brown,),
                  
                  DropdownButton<String>(
                    value: sexo,
                    icon: Icon(Icons.pets),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        sexo = newValue;
                        
                      });
                    },
                    
                    items: <String>['M','F' ]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ],
              ),

              new Padding(
                padding: const EdgeInsets.all(16.0),
                child: new Row(
                  children: <Widget>[
                    new Expanded(child: Text("Fecha de adquisicion:",style: new TextStyle(fontSize:18.0, color: Colors.black))),
                    new FlatButton(
                      onPressed: ()=> _selectDueDate(context), 
                      child: Text(_dateText, style: new TextStyle(fontSize: 18.0, color: Colors.black),))
                  ],
                ),),

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
                       Animal animal =  Animal(
                        especie: especie,
                        name: _nameController.text,
                        raza: raza,
                        sexo: sexo,
                        owner: currentUser.email,
                        fecha: _dateText,
                       
                       
                        
                        
                        id: widget.animal.id
                      );
                       await FirestoreService().updateAnimal(animal);
                      }else{
                       Animal animal =  Animal(
                        especie: especie,
                        name: _nameController.text,
                        raza: raza,
                        sexo: sexo,
                        owner: currentUser.email,
                        fecha: _dateText,
                        
                       
                        
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
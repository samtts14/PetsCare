import 'package:app_tesis/Servicios/firestore_service.dart';
import 'package:app_tesis/Servicios/firestore_service_historial.dart';
import 'package:app_tesis/Servicios/firestore_service_mascotas.dart';
import 'package:app_tesis/Servicios/animal.dart';
import 'package:app_tesis/Servicios/vacunas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddHistorial extends StatefulWidget {
  final Vacuna vacuna;
  const AddHistorial({Key key, this.vacuna}) : super(key: key);
  @override
  _AddHistorialState createState() => _AddHistorialState();
}

class _AddHistorialState extends State<AddHistorial> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _nameController;
  TextEditingController _especie;// No en funcionamiento.
  TextEditingController _raza;
  TextEditingController _sexo;
  TextEditingController _owner;
  DateTime _dateTime;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FocusNode _descriptionNode;
  FirebaseUser user;
  List<String> _tipoDeMascota = <String>[
    'Perro',
    'Gato',
    'Ave',
  ];
  List<String> _razaDeMascota = <String>[
      'Cacatua',
      'Loro',
      'Perico',
  ];

  String name = '';
  String especie = 'Seleciona el tipo de Mascota';
  String raza = 'Seleciona la raza';
  String edad = '';
  String sexo = '';
  String owner = '';
  String detalleVet = '';


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

  DateTime _vetDate = new DateTime.now();
    String _dateString = '';

  Future<Null> _selectVetDate(BuildContext context) async{
    final picked = await showDatePicker(
      context: context,
      initialDate: _vetDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2060)
    );

    if(picked != null){
      setState(() {
        _vetDate = picked;
        _dateString = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController =  TextEditingController(text: isEditMote ?
    widget.vacuna.name: "");
    _especie = TextEditingController(text: isEditMote ?
    widget.vacuna.detalleVeterinario: "");
    _descriptionNode = FocusNode();
     
    

    super.initState();
    _dateText = "${_dueDate.day}/${_dueDate.month}/${_dueDate.year}";

    super.initState();
    _dateString = "${_vetDate.day}/${_vetDate.month}/${_vetDate.year}";
  
  }

  get isEditMote => widget.vacuna != null;

  bool disabledropdown = true;
  List<DropdownMenuItem<String>> menu_items = List();
  final perro = {
    '1' : "Chow-Chow",
    '2' : "Chihuahua",
    '3' : "Husky",
  };

  final gato = {
    '1' : "British Shorthair",
    '2' : "Coon De Maine",
    '3' : "Persas Doll",
  };

  final ave = {
    '1' : "Cacatua",
    '2' : "Loro",
    '3' : "Perico",
  };

  void populateperro(){
    for(String key in perro.keys){
      menu_items.add(DropdownMenuItem<String>(
        value:  perro[key],
        child: Center(
          child: Text(
            perro[key]
          ),
        ),
      ));
    }
  }
  void populategato(){
    for(String key in gato.keys){
      menu_items.add(DropdownMenuItem<String>(
        value:  gato[key],
        child: Center(
          child: Text(
            gato[key]
          ),
        ),
      ));
    }
  }
  void populateave(){
    for(String key in ave.keys){
      menu_items.add(DropdownMenuItem<String>(
        value:  ave[key],
        child: Center(
          child: Text(
            ave[key]
          ),
        ),
      ));
    }
  }
  void valuechanged(_value){
    if(_value == 'Perro'){
      menu_items = [];
      populateperro();
    }else if(_value == 'Gato'){
      menu_items = [];
      populategato();
    }else if(_value == 'Ave'){
      menu_items = [];
      populateave();
    }
    setState(() {
      especie = _value;
      raza = 'Selecciona la raza';
      disabledropdown = false;
    });
  }

  void secondvaluechanged(_value){
    
    setState(() {
      raza = _value;
      disabledropdown = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Datos de Visita al Veterinario'),
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
            //  const SizedBox(height: 10.0)
              
              new Padding(
                padding: const EdgeInsets.all(16.0),
                child: new Row(
                  children: <Widget>[
                    new Expanded(child: Text("Ultima visita al Veterinario",style: new TextStyle(fontSize:18.0, color: Colors.black))),
                    new FlatButton(
                      onPressed: ()=> _selectVetDate(context), 
                      child: Text(_dateString, style: new TextStyle(fontSize: 18.0, color: Colors.black),))
                  ],
                ),
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                // onEditingComplete: (){
                //   FocusScope.of(context).requestFocus(_descriptionNode);
                // },
                
                validator: (value){
                  detalleVet= value;
                  if(value == null || value.isEmpty){
                    return "No puede quedar vacio";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Detalles de la visita al veterinario",
                  border: OutlineInputBorder()
                ),
              ),
              
              const SizedBox(height:20.0),
              RaisedButton(
                color: Colors.yellow[800],
                textColor: Colors.black,
                child:  Text("Guardar"),//poner logo de guardar
                shape: RoundedRectangleBorder(// bordes
                borderRadius: new BorderRadius.circular(20),
                   // side: BorderSide(color: Colors.red)
                    ),
                onPressed: () async {
                  final currentUser = await _firebaseAuth.currentUser();
                  if(_key.currentState.validate()){
                     
                    try {
                      if(isEditMote){
                       Vacuna vacuna =  Vacuna(
                        name: _nameController.text,
                        fechaVeterinario: _dateString,
                        detalleVeterinario: detalleVet,
                        id: widget.vacuna.id
                      );
                       await FirestoreServiceHistorial().updateVacuna(vacuna);
                      }else{
                       Vacuna vacuna =  Vacuna(
                        name: _nameController.text,
                        fechaVeterinario: _dateString,
                        detalleVeterinario: detalleVet,
                        id: widget.vacuna.id
                      );
                        await  FirestoreServiceHistorial().addVacuna(vacuna);
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
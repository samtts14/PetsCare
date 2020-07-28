import 'package:petscare/Servicios/firestore_service_mascotas.dart';
import 'package:petscare/Servicios/animal.dart';
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
  TextEditingController _especie;// No en funcionamiento.
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

    super.initState();
    _dateString = "${_vetDate.day}/${_vetDate.month}/${_vetDate.year}";
  
  }

  get isEditMote => widget.animal != null;

  bool disabledropdown = true;
  List<DropdownMenuItem<String>> menu_items = List();
  final perro = {
    '1' : "Beagle",
    '2' : "Bulldog Frances",
    '3' : "Chihuahua",
    '4' : "Chow chow",
    '5' : "Doberman",
    '6' : "Husky",
    '7' : "Pastor Alemá",
    '8' : "Pitbull",
    '9' : "Pug",
    '10' : "Yorkshire Terrier",
    
  };

  final gato = {
    '1' : "American Wirehair",
    '2' : "Himalayo",
    '3' : "Munchkin",
    '4' : "Persa",
    '5' : "Savannah",
    '6' : "Siames",
    '7' : "Siberiano",
    '8' : "Sokoke",
    '9' : "Snowshoe",
    '10' : "Van Turco",
  };

  final ave = {
    '1' : "Agapornis",
    '2' : "Cacatua",
    '3' : "Canarios",
    '4' : "Diamantes mandarin",
    '5' : "Guacamayo",
    '6' : "Loro",
    '7' : "Paloma",
    '8' : "Perico",
    '9' : "Periquito australiano",
    '10' : "",
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
            //  const SizedBox(height: 10.0),
             
              Center(
                child: Column(
                  children: <Widget>[
                    // Primer dropdown Button el cual escoge la especie
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: DropdownButton<String>(
                        items: [
                          DropdownMenuItem<String>(
                            value: 'Perro',
                            child: Center(
                              child: Text('Perro')
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Gato',
                            child: Center(
                              child: Text('Gato')
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Ave',
                            child: Center(
                              child: Text('Ave')
                            ),
                          )
                        ],
                        onChanged: (_value) => valuechanged(_value),
                        hint: Text('${especie}'),
                      ),
                    ),
                    // Segundo DropDown button, donde se elige la raza dependiendo de cual especie se eliga
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: DropdownButton<String>(
                        items: menu_items ,
                        onChanged: (disabledropdown ? null : (_value) => secondvaluechanged(_value)),
                        hint: Text('${raza}'),
                        disabledHint: Text('Primero selecciona el tipo de Mascota') ,
                      ),
                    ),
                  ],),
              ), 

              Padding(
                      padding: EdgeInsets.all(5.0),
                      child: DropdownButton<String>(
                        items: [
                          DropdownMenuItem<String>(
                            value: 'M',
                            child: Center(
                              child: Text('M')
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'F',
                            child: Center(
                              child: Text('F')
                            ),
                          ),
                          
                        ],
                        onChanged: (_value) => {
                          print(_value.toString()),
                          setState((){
                            sexo = _value;
                          })
                        },
                        hint: Text('Sexo'),
                      ),
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
                ),
              ),
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
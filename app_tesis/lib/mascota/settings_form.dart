import 'package:app_tesis/Servicios/firestore_service.dart';
import 'package:app_tesis/models/pet.dart';
import 'package:flutter/material.dart';
import 'package:app_tesis/shared/constant.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  
  final _formKey = GlobalKey<FormState>();
  final List<String> sexs = ['M', 'F'];
  final List<String> species = ['Bird', 'Cat', 'Dog'];
  final List<String> breeds = ['Husky', 'Chow-Chow', 'Bulldog'];
  final List<String> breedsBirds = ['ave', 'ave1', 'ave3'];
  final List<String> breedsCats = ['cat1', 'cat2', 'cat3'];

  //form values
  String _currentName;
  String _currentBreed;
  String _currentSpecie;
  String _currentSex;
  String _currentAge;

  
  
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            'Pets info.',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height:20.0),
          TextFormField(
            decoration: textInputDecoration,
            validator: (val) => val.isEmpty ? 'Please enter a name' : null,
            onChanged: (val) => setState(() => _currentName = val),
           
          ),
          
          SizedBox(height:10.0),
          DropdownButtonFormField(
            value: _currentSex,
            items: sexs.map((sex){
            return DropdownMenuItem(
              value: sex,
              child: Text('$sex')
            );
            }).toList(),
            onChanged: (val) => setState(() => _currentSex = val),
          ),
          SizedBox(height:10.0),
          DropdownButtonFormField(
            value: _currentSpecie,
            items: species.map((specie){
            return DropdownMenuItem(
              value: specie,
              child: Text('$specie')
            );
            }).toList(),
            onChanged: (val) => setState(() => _currentSpecie = val),
          ),
          
          SizedBox(height:10.0),
          DropdownButtonFormField(
            
            value: _currentBreed,
            items: breeds.map((breed){
            return DropdownMenuItem(
              value: breed,
              child: Text('$breed')
            );
            }).toList(),
            onChanged: (val) => setState(() => _currentBreed = val),
          ),
          SizedBox(height:10.0),
          TextFormField(
            decoration: textInputDecoration,
            validator: (val) => val.isEmpty ? 'Please enter an age' : null,
            onChanged: (val) => setState(() => _currentAge = val),
            
          ),
           
          SizedBox(height: 20.0,),
          // boton de update
          RaisedButton(
            
            color: Colors.blueAccent,
            child: Text('Actualizar',
              style: TextStyle(color: Colors.white ),
              ),
            onPressed: () async{
              Pet pet = Pet(
                name: _currentName,
                species: _currentSpecie,
                breed: _currentBreed,
                age: _currentAge,
                sex: _currentSex,
              );
              await  FirestoreService().addPet(pet);

            },
            ),
        ],)
      
    );
  }
}
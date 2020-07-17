import 'package:PetsCare/Servicios/animal.dart';
import 'package:flutter/material.dart';

class AnimalDetailsPage extends StatelessWidget {
  final Animal animal;

  
  AnimalDetailsPage({Key key, @required this.animal}) : super(key: key);
      
      
      @override
      Widget build(BuildContext context) {
        
        return Scaffold(
          appBar: AppBar(
            title: Text('Mascota'),// titulo del appbar nota cuando se seleccione
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Nombre de mascota: ${animal.name}", style: Theme.of(context).textTheme.title.copyWith(                  
                  fontSize: 20.0
                ),),
                const SizedBox(height: 20.0),//tamano de palabras de notas
                Text("Especie: ${animal.especie}", style:TextStyle(                  
                  fontSize: 16.0
                ),),
                //const SizedBox(height: 30.0),
                const SizedBox(height: 20.0),//tamano de palabras de notas
                Text("Raza: ${animal.raza}", style:TextStyle(                
                  fontSize: 16.0
                ),),
                const SizedBox(height: 20.0),//tamano de palabras de notas
                Text("Sexo: ${animal.sexo}", style:TextStyle(                
                  fontSize: 16.0
                ),),
                
              ],
              
            ) 
          ),
          
        );
      }
    
      
}
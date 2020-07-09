import 'package:app_tesis/Servicios/animal.dart';
import 'package:app_tesis/Servicios/vacunas.dart';
import 'package:flutter/material.dart';

class HistorialDetailsPage extends StatelessWidget {
  final Vacuna vacuna;

  
  HistorialDetailsPage({Key key, @required this.vacuna}) : super(key: key);
      
      
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
                Text("Nombre de mascota: ${vacuna.name}", style: Theme.of(context).textTheme.title.copyWith(                  
                  fontSize: 20.0
                ),),
                const SizedBox(height: 20.0),//tamano de palabras de notas
                Text("Especie: ${vacuna.detalleVeterinario}", style:TextStyle(                  
                  fontSize: 16.0
                ),),
                
                const SizedBox(height: 20.0),//tamano de palabras de notas
                Text("Ultima visita al Veterinario: ${vacuna.fechaVeterinario}", style:TextStyle(               
                  fontSize: 16.0
                ),),
                
              ],
              
            ) 
          ),
          
        );
      }
    
      
}
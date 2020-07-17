import 'package:PetsCare/Servicios/firestore_service.dart';
import 'package:PetsCare/Servicios/firestore_service_historial.dart';

import 'package:PetsCare/Servicios/animal.dart';
import 'package:PetsCare/Servicios/vacunas.dart';
import 'package:PetsCare/h-animal/add_animal.dart';
import 'package:PetsCare/models/user.dart';
import 'package:PetsCare/screen/home/Historial/add_historial.dart';
import 'package:PetsCare/screen/home/Historial/historial_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:PetsCare/h-animal/animal_details.dart';

class HistorialVacuna extends StatelessWidget {
  final String email;
  HistorialVacuna({Key key, this.email}) : super(key:key);
  
  
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        backgroundColor: Colors.brown[600],
      ),
     body: StreamBuilder(
       stream: FirestoreServiceHistorial().getVacunas(email),
       builder: (BuildContext context, AsyncSnapshot <List<Vacuna>> snapshot){
         if(snapshot.hasError || !snapshot.hasData){
           return CircularProgressIndicator();//cargando. Hay que centrarlo
         }
         return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder:(BuildContext context, int index){
             Vacuna vacuna = snapshot.data[index];
              return Card(
                child: ListTile(
                title: Text(vacuna.name),
                subtitle: Text(vacuna.detalleVeterinario),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    //  IconButton(
                    //   color: Colors.blue,
                    //   icon: Icon(Icons.edit),
                    //   onPressed: () => Navigator.push(context,
                    //     MaterialPageRoute(
                    //       builder: (_) => AddHistorial(vacuna : vacuna),
                    //     ))
                    //   ),
                    IconButton(
                      color: Colors.red,
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteAnimal(context,vacuna.id),
                   ),           
                  ],
                ),
                onTap:  () => Navigator.push(
                  context, MaterialPageRoute(
                    builder: (_) => HistorialDetailsPage()
                  ),
                ),
              ));
            } ,
         );
       },
      ),
       
       floatingActionButton: FloatingActionButton(
         backgroundColor: Colors.brown[500],
         child:  Icon(Icons.add),
         onPressed: (){
           Navigator.push(context, MaterialPageRoute(
              builder: (_) => AddHistorialPage(email: email),
           )
          );
         },
       ),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.help_outline),
              onPressed: (){},// enviar a pantalla de ayuda de la app
            ),
          ],
        )
      ),
    );
  }

  void _deleteAnimal(BuildContext context,String id) async{
    if(await _showConfirmationDialog(context)){
      try {
            await FirestoreServiceHistorial().deleteVacuna(id);
        } catch (e) {
          print(e);
     }
    }
  } 

  

  Future<bool> _showConfirmationDialog(BuildContext context)async{
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        content:Text("Estás seguro de borrar esta mascota?"),
        actions: <Widget>[
          FlatButton(
            textColor:  Colors.red,
            onPressed: () => Navigator.pop(context,true), 
            child: Text("Borrar"),
          ),
           FlatButton(
             textColor: Colors.black,
            onPressed: () => Navigator.pop(context,false), 
            child: Text("No"),
          )
        ],
      )
    );
  }

}
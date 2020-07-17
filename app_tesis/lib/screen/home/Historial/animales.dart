import 'package:PetsCare/Servicios/firestore_service_mascotas.dart';
import 'package:PetsCare/Servicios/animal.dart';
import 'package:PetsCare/h-animal/add_animal.dart';
import 'package:PetsCare/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:PetsCare/h-animal/animal_details.dart';

class Mascotas extends StatelessWidget {
  final String email;
  Mascotas({Key key, this.email}) : super(key:key);
  
  
  String prueba = "yoggi@hotmail.com";
  @override
  Widget build(BuildContext context) {
    print(Text("${email} BUENOOOOOOO"));
    return Scaffold(
      appBar: AppBar(
        title: Text('Mascota'),
        backgroundColor: Colors.brown[600],
      ),
     body: StreamBuilder(
       stream: FirestoreService().getAnimales(email),
       builder: (BuildContext context, AsyncSnapshot <List<Animal>> snapshot){
         if(snapshot.hasError || !snapshot.hasData){
           return CircularProgressIndicator();//cargando. Hay que centrarlo
         }
         return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder:(BuildContext context, int index){
             Animal animal = snapshot.data[index];
              return Card(
                child: ListTile(
                title: Text(animal.name),
                subtitle: Text(animal.especie),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                     IconButton(
                      color: Colors.blue,
                      icon: Icon(Icons.edit),
                      onPressed: () => Navigator.push(context,
                        MaterialPageRoute(
                          builder: (_) => AddAnimalPage(animal : animal),
                        ))
                      ),
                    IconButton(
                      color: Colors.red,
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteAnimal(context,animal.id, animal.name),
                   ),           
                  ],
                ),
                onTap:  () => Navigator.push(
                  context, MaterialPageRoute(
                    builder: (_) => AnimalDetailsPage(animal: animal)
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
              builder: (_) => AddAnimalPage()
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

  void _deleteAnimal(BuildContext context,String id, mascota) async{
    if(await _showConfirmationDialog(context)){
      try {
            await FirestoreService().deleteAnimal(id);
            await FirestoreService().deleteAnimalFromHistorial(mascota);
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
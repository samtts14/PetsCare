import 'package:petscare/Servicios/firestore_historial.dart';
import 'package:petscare/Servicios/historial_ser.dart';
import 'package:petscare/screen/home/Historial/add_historial.dart';
import 'package:petscare/screen/home/Historial/historial_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Historial2 extends StatefulWidget {
  final String email;
  Historial2({Key key, @required this.email}) : super(key:key);
  @override
  _Historial2State createState() => _Historial2State();
}

class _Historial2State extends State<Historial2> {
  
  var mascota;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        backgroundColor: Colors.brown[600],
        actions: <Widget>[
          StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection("pets").where("owner", isEqualTo: widget.email).snapshots(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  Text("Cargando");
                }
                else{
                  List<DropdownMenuItem> mascotas=[];
                  for(int i = 0; i < snapshot.data.documents.length; i++){
                    DocumentSnapshot snap = snapshot.data.documents[i];
                    mascotas.add(
                      DropdownMenuItem(
                        child: Text(
                          snap.data["name"],
                          style: TextStyle(color: Colors.black),
                        ),
                        value: "${snap.data["name"]}",
                      )
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.pets, size: 25.0,color: Colors.brown),
                      DropdownButton(
                        items:mascotas,
                        onChanged: (mascotas){
                          final snackBar = SnackBar(
                            content: Text("Selecciono a ${mascotas}",style: TextStyle(color: Colors.cyan)),
                            );
                            Scaffold.of(context).showSnackBar(snackBar);
                            setState(() {
                              mascota = mascotas;
                              print("${widget.email}");
                            });
                        },
                        value: mascota,
                        
                        isExpanded: false,
                        hint: new Text('Mascota', style:TextStyle(color: Colors.white))

                      )
                    ],
                  );
                }
              },
            ),
        ],
      ),
     body: StreamBuilder(
       stream: FirestoreService().getHistorial(mascota, widget.email),
       builder: (BuildContext context, AsyncSnapshot <List<HistorialServ>> snapshot){
         if(snapshot.hasError || !snapshot.hasData){
           return CircularProgressIndicator();//cargando. Hay que centrarlo
         }
         return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder:(BuildContext context, int index){
             HistorialServ historial = snapshot.data[index];
              return Card(
                child: ListTile(
                  title: Text(historial.fechaString),
                  subtitle: Text(historial.descripcion),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        color: Colors.red,
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteNote(context,historial.id),
                    ),           
                    ],
                  ),
                  onTap:  () => Navigator.push(
                    context, MaterialPageRoute(
                      builder: (_) => HistorialDetailsPage(historial: historial)
                    ),
                  ),
                )
              );
            } ,
         );
       },
      ),
       
       floatingActionButton: FloatingActionButton(
         backgroundColor: Colors.brown[500],
         child:  Icon(Icons.add),
         onPressed: (){
           Navigator.push(context, MaterialPageRoute(
              builder: (_) => AddHistorialPage(email: widget.email,)
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
              icon: Icon(Icons.help_outline, color:  Colors.transparent,),
              onPressed: (){},// enviar a pantalla de ayuda de la app
            ),
          ],
        )
      ),
    );
  }

  void _deleteNote(BuildContext context,String id) async{
    if(await _showConfirmationDialog(context)){
      try {
            await FirestoreService().deleteHistorial(id);
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
        content:Text("Estás seguro de borrar esta nota?"),
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
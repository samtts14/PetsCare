import 'package:app_tesis/Servicios/firestore_historial.dart';
import 'package:app_tesis/Servicios/historial_ser.dart';
import 'package:app_tesis/screen/home/Historial/add_historial.dart';
import 'package:app_tesis/screen/home/Historial/historial_details.dart';
import 'package:flutter/material.dart';
import 'package:app_tesis/cnotas/note_details.dart';

class Historial2 extends StatelessWidget {
  final String email;
  Historial2({Key key, @required this.email}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        backgroundColor: Colors.brown[600],
      ),
     body: StreamBuilder(
       stream: FirestoreService().getHistorial(email),
       builder: (BuildContext context, AsyncSnapshot <List<HistorialServ>> snapshot){
         if(snapshot.hasError || !snapshot.hasData){
           return CircularProgressIndicator();//cargando. Hay que centrarlo
         }
         return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder:(BuildContext context, int index){
             HistorialServ historial = snapshot.data[index];
              return ListTile(
                title: Text(historial.titulo),
                subtitle: Text(historial.descripcion),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                     IconButton(
                      color: Colors.blue,
                      icon: Icon(Icons.edit),
                      onPressed: () => Navigator.push(context,
                        MaterialPageRoute(
                          builder: (_) => AddHistorialPage(historial : historial,email: email,),
                        ))
                      ),
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
              builder: (_) => AddHistorialPage()
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

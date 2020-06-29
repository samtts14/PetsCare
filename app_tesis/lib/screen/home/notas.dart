import 'package:app_tesis/Servicios/firestore_service.dart';
import 'package:app_tesis/Servicios/note.dart';
import 'package:app_tesis/cnotas/add_note.dart';
import 'package:flutter/material.dart';
import 'package:app_tesis/cnotas/note_details.dart';

class Notas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notas'),
        backgroundColor: Colors.brown[600],
      ),
     body: StreamBuilder(
       stream: FirestoreService().getNotas(),
       builder: (BuildContext context, AsyncSnapshot <List<Note>> snapshot){
         if(snapshot.hasError || !snapshot.hasData){
           return CircularProgressIndicator();//cargando. Hay que centrarlo
         }
         return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder:(BuildContext context, int index){
              
             Note note = snapshot.data[index];
              return ListTile(
                title: Text(note.title),
                subtitle: Text(note.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      color: Colors.blue,
                      icon: Icon(Icons.edit),
                      onPressed: () => Navigator.push(context,
                        MaterialPageRoute(
                          builder: (_) => AddNotePage(note : note),
                        ))
                      ),
                    IconButton(
                      color: Colors.red,
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteNote(context,note.id),
                   ),           
                  ],
                ),
                onTap:  () => Navigator.push(
                  context, MaterialPageRoute(
                    builder: (_) => NoteDetailsPage(note: note)
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
              builder: (_) => AddNotePage()
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
            await FirestoreService().deleteNote(id);
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

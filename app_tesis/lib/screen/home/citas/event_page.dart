import 'package:app_tesis/screen/home/citas/editEventPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class EventPage extends StatefulWidget {
  EventPage({this.user, this.googleSignIn});
  final FirebaseUser user;
  final GoogleSignIn googleSignIn;
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: StreamBuilder(
              stream: Firestore.instance.collection("Citas")
             // .where("title")
              .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                if(!snapshot.hasData)
                return new Container(child: Center(
                  child: CircularProgressIndicator(),
                ));
                return new CitasList(document: snapshot.data.documents,);//presentar datos
              }
            ),
          ),
          Container(
    
          ),
        ],
      ),
    );
  }
}

class CitasList extends StatelessWidget {
  CitasList({this.document});
  final List<DocumentSnapshot> document;
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount:  document.length,
      itemBuilder: (BuildContext context, int i){

        String title = document[i].data["title"].toString();
        String description = document[i].data["description"].toString();
        String date = document[i].data["date"].toString();
        String time = document[i].data["time"].toString();

        return Dismissible(
          key: new Key(document[i].documentID),
          onDismissed: (direction){
            Firestore.instance.runTransaction((transaction) async{
                DocumentSnapshot snapshot = 
                await transaction.get(document[i].reference);
                await transaction.delete(snapshot.reference);
            });

            Scaffold.of(context).showSnackBar(
              new SnackBar(content: new Text("Cita eliminada"),)
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left:16.0, top: 8.0, right: 16.0, bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(title, style: new TextStyle(fontSize: 20.0,
                            fontWeight: FontWeight.bold, letterSpacing: 1.0),),
                        ),//titulo de cada cita
                        Row(//parte donde muestra la parte de la fecha
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Icon(Icons.date_range, color: Colors.brown,),
                            ),
                            Text(date, style: new TextStyle(fontSize: 18.0),),
                          ],
                        ),
                        Row(//parte donde muestra la parte de la hora
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Icon(Icons.access_time, color: Colors.brown,),
                            ),
                            Text(time, style: new TextStyle(fontSize: 18.0),),
                          ],
                        ),
                        Row( // parte de la descripcion
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Icon(Icons.note, color: Colors.brown,),
                            ),
                            new Expanded(child: Text(description, style: new TextStyle(fontSize: 18.0,),)),
                          ],
                        )
                      ]
                    ),
                  ),
                ),
                new IconButton(
                  icon: Icon(Icons.edit), 
                  onPressed: (){
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context)=> EditEventPage(
                        title: title,
                        description: description,
                        date: document[i].data["date"],
                        time: document[i].data["time"],
                        index: document[i].reference,
                      )
                    ));
                  }
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
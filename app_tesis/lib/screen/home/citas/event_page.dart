import 'package:petscare/screen/home/citas/editEventPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

const EVENTS_KEY = "fetch_events";
class EventPage extends StatefulWidget {
  EventPage({this.user, this.googleSignIn, Key key, this.email}) : super(key:key);
  final FirebaseUser user;
  final GoogleSignIn googleSignIn;
  
  @override
  _EventPageState createState() => _EventPageState();
  final String email;
  
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
              stream: Firestore.instance.collection("Citas").where("owner", isEqualTo: widget.email)
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
        ],
      ),
    );
  }
}

class CitasList extends StatefulWidget {
  final List<DocumentSnapshot> document;
  const CitasList({Key key, this.document}) : super(key: key);
  @override
  _CitasListState createState() => _CitasListState();
}

class _CitasListState extends State<CitasList> {
  List<String>_events = [];

  

  @override
  Widget build(BuildContext context) {
    
    return new ListView.builder(
      itemCount:  widget.document.length,
      itemBuilder: (BuildContext context, int i){

        String title = widget.document[i].data["title"].toString();
        String description = widget.document[i].data["description"].toString();
        String date = widget.document[i].data["date"].toString();
        String time = widget.document[i].data["time"].toString();

        return Dismissible(
          key: new Key(widget.document[i].documentID),
          onDismissed: (direction){
            Firestore.instance.runTransaction((transaction) async{
                DocumentSnapshot snapshot = 
                await transaction.get(widget.document[i].reference);
                await transaction.delete(snapshot.reference);

                void _onClickClear() async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.remove(EVENTS_KEY);
                  _events = [];
                }
            });

            Scaffold.of(context).showSnackBar(
              new SnackBar(content: new Text("Cita eliminada"),)
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left:16.0, top: 8.0, right: 16.0, bottom: 8.0),
            child: Card(
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
                  icon: Icon(Icons.edit, color: Colors.yellow[800],), 
                  onPressed: (){
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context)=> EditEventPage(
                        title: title,
                        description: description,
                        date: widget.document[i].data["date"],
                        time: widget.document[i].data["time"],
                        index: widget.document[i].reference,
                      )
                    ));
                  }
                ),
              ],
            ),
          ),
        ));
      },
    );
  }
}


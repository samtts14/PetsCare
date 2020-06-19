import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'add_mascota.dart';

class Mascotas extends StatefulWidget {
  Mascotas({this.user, this.googleSignIn});
  final FirebaseUser user;
  final GoogleSignIn googleSignIn;

  
  
  @override
  _MascotasState createState() => _MascotasState();
}

class _MascotasState extends State<Mascotas> {
   final _auth = FirebaseAuth.instance;
    String userEmail;
    void getCurrentUserEmail() async {
    final user =
              await _auth.currentUser().then((value) => userEmail = value.email);
    }
  bool _isChecked = false;
  void onChanged(bool value){
    setState((){
          _isChecked = value;
        });
      }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: StreamBuilder(
              stream: Firestore.instance.collection('pets')
              .where("owner's email", isEqualTo: userEmail).snapshots(),
            
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                if(!snapshot.hasData)
                return new Container(child: Center(child: CircularProgressIndicator(),));

                return new PetList(document: snapshot.data.documents,);
              }
            ),
          ),

          Container(
            height: 120.0,
            width: double.infinity,
            color: Colors.purple,
          ),
          Container(
            child: Column(
                  children:<Widget>[
                    new Row(
                      children: <Widget>[
                        new Text('Alimentar Mascota'),
                        new Checkbox(value: _isChecked, onChanged: (bool value){onChanged(value);}),
                      ],
                    )
                  ]),
      ),
        ],
        
      ),
      
      floatingActionButton: new FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new AddMascota())
            );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: new BottomAppBar(
        elevation: 20.0,
        color: Colors.purple,
        child: ButtonBar(
          children:<Widget>[],
          )
      ),
    );
  }
}

class PetList extends StatelessWidget {
  PetList({this.document});
  final List<DocumentSnapshot> document;
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: document.length,
      itemBuilder: (BuildContext context, int i){
        String title = document[i].data['name'].toString();
        return Text(title);
      }
      
    );
  }
}
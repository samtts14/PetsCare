
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Historial extends StatefulWidget {

  @override
  _HistorialState createState() => _HistorialState();
}

class _HistorialState extends State<Historial> {
  var selectedCurrency, selectedType;
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  List<String> _accountType = <String>[
    'Chowchow',
    'Chiguagua',
    'Pug',
    'Doberman'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            alignment: Alignment.centerLeft,
            child: Text("Historial de mascotas",
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
          actions: <Widget>[
            
          ],
        ),
        body: Form(
          key: _formKeyValue,
          autovalidate: true,
          child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            children: <Widget>[
              
              SizedBox(height: 40.0),
              StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection("pets").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      const Text("Cargando...");
                    else {
                      List<DropdownMenuItem> currencyItems = [];
                      for (int i = 0; i < snapshot.data.documents.length; i++) {
                        DocumentSnapshot snap = snapshot.data.documents[i];
                        currencyItems.add(
                          DropdownMenuItem(
                            child: Text(
                              snap.data['name'].toString(), // presenta el nombre en el dropdown
                              style: TextStyle(color: Colors.brown),
                            ),
                            value: "${snap.documentID}",
                          ),
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(width: 50.0),
                          DropdownButton(
                            items: currencyItems,
                            onChanged: (currencyValue) {
                              final snackBar = SnackBar(
                                content: Text(
                                  'Mascota $currencyValue',
                                  style: TextStyle(color: Colors.brown,
                                ),
                               ) );
                              Scaffold.of(context).showSnackBar(snackBar);
                              setState(() {
                                selectedCurrency = currencyValue;
                              });
                            },
                            
                            value: selectedCurrency,
                            isExpanded: false,
                            hint: new Text(
                              "Selecciona Mascota",
                              style: TextStyle(color: Colors.brown),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
              SizedBox(
                height: 150.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RaisedButton(
                      color: Colors.brown,
                      textColor: Colors.white,
                      child: Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text("Aceptar", style: TextStyle(fontSize: 14.0)),
                            ],
                          )),
                      onPressed: () {},
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0))),
                ],
              ),
            ],
          ),
        ));
  }
}
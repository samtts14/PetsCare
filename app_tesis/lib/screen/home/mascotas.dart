import 'package:app_tesis/mascota/agregar_mascota.dart';
import 'package:app_tesis/mascota/petslist.dart';
import 'package:app_tesis/mascota/settings_form.dart';
import 'package:app_tesis/models/pet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_tesis/Servicios/petdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Mascotas extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    void _muestraSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Scaffold(
          resizeToAvoidBottomPadding: false,
          body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal:60.0),
                child: SettingsForm(),
            ),
          ),
        );
      });
    }
    

    return StreamProvider<List<Pet>>.value(
        value: PetData().pets,
        child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          elevation: 0.0,
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(height: 50.0,),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _muestraSettingsPanel(),
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        

        body: PetsList()
      
      
      ),
    );
  }
}
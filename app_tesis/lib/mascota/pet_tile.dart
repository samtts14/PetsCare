import 'package:flutter/material.dart';
import 'package:app_tesis/models/pet.dart';

class PetTile extends StatelessWidget {
  
  final Pet pet;
  PetTile({this.pet});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: Icon(Icons.pets),
          title: Text(pet.name),
          subtitle: Text(pet.breed),
        )
      )
    );
  }
}
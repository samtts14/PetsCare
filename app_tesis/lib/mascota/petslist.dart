import 'package:app_tesis/mascota/pet_tile.dart';
import 'package:app_tesis/models/pet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PetsList extends StatefulWidget {
  @override
  _PetsListState createState() => _PetsListState();
}

class _PetsListState extends State<PetsList> {
  @override
  Widget build(BuildContext context) {
    
    final pets = Provider.of<List<Pet>>(context) ?? [];
    // print(pets.documents);
    
   

    return ListView.builder(
      itemCount: pets.length,
      itemBuilder: (context, index){
        return PetTile(pet: pets[index]);
      },
      
    );

  }
}
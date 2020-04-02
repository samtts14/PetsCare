import 'package:app_tesis/models/pet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PetData{
 
  final String uid;
  PetData({ this.uid });

  final CollectionReference petsCollection = Firestore.instance.collection('pets');

  Future updatePetData(String name, String species, String breed, String sex, String age, String owner) async{
    return await petsCollection.document(uid).setData({
      'name': name,
      'species' : species,
      'breed' : breed,
      'sex' : sex,
      'age' : age,
      'owner': owner,
    });
  }

  // lista de mascotas
  List<Pet> _petListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Pet(
        name: doc.data['name'] ?? '',
        species: doc.data['species'] ?? '',
        breed: doc.data['breed'] ?? '',
        sex: doc.data['sex'] ?? '',
        age: doc.data['age'] ?? ''
      );
    }).toList();
  }
  

  Stream<List<Pet>> get pets{
    return petsCollection.snapshots().map(_petListFromSnapshot);
  }

}
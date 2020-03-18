import 'package:cloud_firestore/cloud_firestore.dart';

class PetData{
 
  final String uid;
  PetData({ this.uid });

  final CollectionReference petsCollection = Firestore.instance.collection('pets');

  Future updatePetData(String name, String species, String breed, String sex, String age) async{
    return await petsCollection.document(uid).setData({
      'name': name,
      'species' : species,
      'breed' : breed,
      'sex' : sex,
      'age' : age,
    });
  }
}
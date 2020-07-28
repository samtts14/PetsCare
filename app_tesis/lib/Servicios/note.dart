import 'package:petscare/models/user.dart';

class Note{
  final String title;
  final String description;
  final String owner;
  final String id;
  //String usuario;

  Note({this.title, this.description, this.owner, this.id}); 

  Note.fromMap(Map<String, dynamic> data, String id):
    title = data["title"],
    description = data["description"],
    owner = data['owner'],
    id= id;
    // usuario = usuario;    
    

    Map<String, dynamic> toMap(){
      return {
        "title" : title,
        "description" : description,
        "owner" : owner,
        //"uid" : usuario,
        
      };
    }
}
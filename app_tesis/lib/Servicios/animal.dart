class Animal{
  final String name;
  final String especie;
  final String sexo;
  final String raza;
  final String ownerEmail;
  final String id;

  Animal({this.name, this.especie, this.id, this.sexo,this.raza,this.ownerEmail}); 

  Animal.fromMap(Map<String, dynamic> data, String id):
    name = data["name"],
    especie = data["description"],
    sexo = data["sexo"],
    raza= data["raza"],
    ownerEmail = data["ownerEmail"],
    id=id;

    Map<String, dynamic> toMap(){
      return {
        "name" : name,
        "especie" : especie,
        "sexo" : sexo,
        "raza" : raza
      };
    }
}
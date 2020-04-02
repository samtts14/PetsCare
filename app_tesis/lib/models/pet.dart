class Pet{

  final String name;
  final String species;
  final String breed;
  final String sex;
  final String age;
  final String owner;

  Pet({this.name, this.species, this.breed, this.sex, this.age, this.owner});

  Pet.fromMap(Map<String, dynamic> data, String id):
    name = data['name'],
    breed = data['breed'],  
    species = data['species'],  
    sex = data['sex'],  
    age = data['age'],
    owner = data['owner']; 
    

    Map<String, dynamic> toMap(){
      return {
        'name' : name,
        'species' : species,
        'breed' : breed,
        'sex' : sex,
        'age' : age,
        'owner' : owner,
         
      };
    }
}
class Pet{

  final String name;
  final String species;
  final String breed;
  final String sex;
  final String age;

  Pet({this.name, this.species, this.breed, this.sex, this.age});

  Pet.fromMap(Map<String, dynamic> data, String id):
    name = data['name'],
    breed = data['breed'],  
    species = data['species'],  
    sex = data['sex'],  
    age = data['age'];   
    

    Map<String, dynamic> toMap(){
      return {
        'name' : name,
        'species' : species,
        'breed' : breed,
        'sex' : sex,
        'age' : age,
         
      };
    }
}
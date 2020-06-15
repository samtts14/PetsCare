import 'package:app_tesis/Servicios/animal.dart';
import 'package:flutter/material.dart';

class AnimalDetailsPage extends StatelessWidget {
  final Animal animal;

  const AnimalDetailsPage({Key key, @required this.animal}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mascota'),// titulo del appbar nota cuando se seleccione
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(animal.name, style: Theme.of(context).textTheme.title.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
            ),),
            const SizedBox(height: 20.0),//tamano de palabras de notas
            Text(animal.especie, style:TextStyle(
              fontSize: 16.0
            ),),
            //const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
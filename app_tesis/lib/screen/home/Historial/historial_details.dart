import 'package:petscare/Servicios/historial_ser.dart';
import 'package:flutter/material.dart';

class HistorialDetailsPage extends StatelessWidget {
  final HistorialServ historial;

  const HistorialDetailsPage({Key key,  this.historial}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),// titulo del appbar nota cuando se seleccione
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(historial.titulo, style: Theme.of(context).textTheme.title.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
            ),),
            const SizedBox(height: 20.0),//tamano de palabras de notas
            Text(historial.descripcion, style:TextStyle(
              fontSize: 16.0
            ),),
            const SizedBox(height: 20.0),//tamano de palabras de notas
            Text(historial.fecha, style:TextStyle(
              fontSize: 16.0
            ),),
          ],
        ),
      ),
    );
  }
}
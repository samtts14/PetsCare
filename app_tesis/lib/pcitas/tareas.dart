import 'package:flutter/material.dart';

class Tareas extends StatefulWidget {
  @override
  _TareasState createState() => _TareasState();
}

class Tarea {
  final String tarea;
  final bool isFinish;
  const Tarea(this.tarea, this.isFinish);
}

final List<Tarea> _tareaList = [
    new Tarea('Cita 1', false),
    new Tarea('Cita 2', false),
    new Tarea('Cita 3', false),
    new Tarea('Cita 4', true),
];

class _TareasState extends State<Tareas> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: _tareaList.length,
      itemBuilder: (context, index){
        return _tareaList[index].isFinish 
          ? tareaCompleta(_tareaList[index].tarea)
          : tareaIncompleta(_tareaList[index].tarea);  
      },
    );
  }

  Widget tareaIncompleta(String tarea) {
    return Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 24.0),
            child: Row(
            children: <Widget>[
              Icon(Icons.radio_button_unchecked, color: Theme.of(context).accentColor, size: 20,
              ),
              SizedBox(width: 28),
              Text(tarea)
            ],
          ),
        );
  }
   Widget tareaCompleta(String tarea) {
    return Container(
      foregroundDecoration: BoxDecoration(color: Color(0x60FDFDFD)),
      child: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 24.0),
              child: Row(
              children: <Widget>[
                Icon(Icons.radio_button_checked, color: Theme.of(context).accentColor, size: 20,
                ),
                SizedBox(width: 28),
                Text(tarea)
              ],
            ),
          ),
    );
  }

}
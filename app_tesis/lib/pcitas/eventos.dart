import 'package:app_tesis/pcitas/widget/custom_icon_decoration.dart';
import 'package:flutter/material.dart';

class EventosState extends StatefulWidget {
  @override
  _EventosStateState createState() => _EventosStateState();
}

class Evento {
  final String tiempo;
  final String tarea;
  final String desc;
  final bool isFinish;

  const Evento(this.tiempo, this.tarea, this.desc, this.isFinish);
}

final List<Evento> eventoList = [ 
    new Evento("10:00",'Cita 1',"presonal", true),
    new Evento("10:20",'Cita 2',"animal", true),
    new Evento("10:50",'Cita 3',"presonal", false),
    new Evento("11:00",'Cita 4',"presonal", false),
];
class _EventosStateState extends State<EventosState> {
  @override
  Widget build(BuildContext context) {
    double iconSize = 20;

    return ListView.builder(
      itemCount: eventoList.length,
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index){
        return Padding(
          padding: const  EdgeInsets.only(left: 24.0, right: 24),
          child: Row(
            children: <Widget>[
              _lineStyle(context, iconSize, index, eventoList.length,
                   eventoList[index].isFinish),
              _displayTime(eventoList[index].tiempo),
              
            _displayContent(eventoList[index]) 
            ],
          ),
       );
      },
    );
  }

  Expanded _displayContent(Evento evento) {
    return Expanded(
          child: Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
              child: Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                      color: Color(0x20000000),
                      blurRadius: 5,
                      offset: Offset(0, 3)
                    )]
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text( evento.tarea),// titulo
                      SizedBox(
                        height: 12,
                      ),
                      Text(evento.desc)//detalle
                    ],
                  ),
                ),
              ),
            );
  }

  Container _displayTime(String tiempo) {
    return Container(
              width: 80, 
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(tiempo)// hora cita
              ));
  }

  Container _lineStyle(BuildContext context, double iconSize, int index, int listLenght, bool isFinish) {
    return Container(//linea
            decoration: CustomIconDecoration(
              iconSize: iconSize,
              lineWidth: 1,
              firstData: index == 0 ?? true,
              lastData: index ==  listLenght - 1 ?? true
            ),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(offset: Offset(0,3), 
                      color: Color(0x20000000), 
                      blurRadius: 5)
                    ]
                  ),
                  child: Icon(
                        isFinish
                        ? Icons.fiber_manual_record 
                        : Icons.radio_button_unchecked, 
                    size: 20, color: Theme.of(context).accentColor,),
                ),);
  }
}


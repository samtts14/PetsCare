import 'package:app_tesis/widgetsCitas/custom_icon_decoration.dart';
import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class Event{
  final String time;
  final String task;
  final String desc;
  final bool isFinish;

  const Event(this.time, this.task, this.desc, this.isFinish);
}

final List<Event> _eventList = [
    new Event ("8:05","Tarea 1.","personal", true),
    new Event ("9:12","Tarea 2.","Mascota", true),
    new Event ("11:15","Tarea 3.","personal", false),
    new Event ("3:30","Tarea 4.","personal", false),
    new Event ("6:54","Tarea 5.","personal", false),
];

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    double iconSize = 20;

    return ListView.builder(
      itemCount: _eventList.length,
      padding:  const EdgeInsets.all(0),
      itemBuilder: (context, index){
        return Padding(
          padding: const EdgeInsets.only(left:24.0, right: 24.0),
          child: Row(
          children: <Widget>[
            _lineStyle(context, iconSize, 
              index, _eventList.length, _eventList[index].isFinish),
            _displayTime(_eventList[index].time),
            _displayContent(_eventList[index])
          ],
        ),
    );
      },
    );
  }

  Expanded _displayContent(Event event){
    return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
              child:Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(color: Colors.white, 
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                color: Color(0x20000000),
                blurRadius: 5,
                offset: Offset(0,3)
                )]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(event.task ),//nombre de cita
                  SizedBox(
                    height: 12
                  ),
                  Text(event.desc ), //tipo de cita   
                ],
              ),
            ),
      ),
          );
  }

  Container _displayTime(String time) {
    return Container(width:80, 
            child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(time),)
          );
  }

  Container _lineStyle(BuildContext context, double iconSize, int index, int listLenght, bool isFinish) {
    return Container(
            decoration: CustomIconDecoration(
              iconSize: iconSize,
              lineWidth: 1,
              firstData: index == 0 ?? true,
              lastData: index == listLenght - 1 ?? true
            ),
            child:Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                boxShadow: [
                  BoxShadow(offset: Offset(0,3), color: Color(0x20000000),
                  blurRadius: 5)
                ]
              ),
              child: Icon(isFinish
                ? Icons.fiber_manual_record 
                : Icons.radio_button_unchecked, 
                size: 20, color: Colors.yellow[800]),
            )
          );
  }
}



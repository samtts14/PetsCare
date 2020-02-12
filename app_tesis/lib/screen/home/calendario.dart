import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Calendario extends StatefulWidget {
  @override
  _CalendarioState createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CalendarController();
    _events = {};
    _eventController= TextEditingController();
    _selectedEvents = [];
    initPrefs();
  }
  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
       _events = Map<DateTime,List<dynamic>>.from(decodeMap(json.decode(prefs.getString("events") ?? "{")));
    });
   
  }

  Map<String,dynamic>encodeMap(Map<DateTime,dynamic> map){
    Map<String,dynamic> newMap = {};
    map.forEach((key, value){
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime,dynamic>decodeMap(Map<String,dynamic> map){
    Map<DateTime,dynamic> newMap = {};
    map.forEach((key,value){
      newMap[DateTime.parse(key)]= map[key];
    });
    return newMap;
  }
  
  @override
  Widget build(BuildContext context) {
    
    _showAddDialog(){
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: TextField(
            controller: _eventController,

          ),
          actions: <Widget>[
            FlatButton(
              child: Text ("Save"),
              onPressed:(){
                if(_eventController.text.isEmpty) return;
                setState(() {
                    if(_events[_controller.selectedDay] != null){
                    _events[_controller.selectedDay].add(_eventController.text);
                    }else{
                      _events[_controller.selectedDay]= [_eventController.text];
                  }
                  prefs.setString("events", json.encode(encodeMap(_events)));
                  _eventController.clear();
                  Navigator.pop(context);
                });         
              },
            ),
          ],
        )
      );
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('Calendario'),
        backgroundColor: Colors.brown[600]
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(//dia actual
              events: _events,
              initialCalendarFormat: CalendarFormat.month,
              calendarStyle: CalendarStyle(
                todayColor: Colors.red[800],
                selectedColor: Theme.of(context).primaryColor,
                todayStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white
                )
              ),
              headerStyle: HeaderStyle(//boton de las semanas, meses, etc...
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.yellow[800],
                  borderRadius: BorderRadius.circular(20.0)
                ),
                formatButtonTextStyle: TextStyle(
                  color: Colors.black
                ),
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: (date,events){
                setState(() {
                  _selectedEvents = events;
                });
                //print(date.toIso8601String());
              },
              builders: CalendarBuilders(//efecto de dia seleccionado
                selectedDayBuilder: (context,date,events) => 
                Container(
                  margin: const EdgeInsets.all(4.0),// tamano cuadro de seleccion
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  
                  child: Text
                  (date.day.toString(), style: TextStyle(color: Colors.white),)
                ),
                todayDayBuilder: (context, date, events) => 
                Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                  color: Colors.red[800],
                   borderRadius: BorderRadius.circular(20.0)
                    
                  ),
                  
                  child: Text
                  (date.day.toString(), style: TextStyle(color: Colors.white),)
                ),
              ),
              calendarController: _controller),
              ..._selectedEvents.map((event) => ListTile(
                  title: Text(event),
              )),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed:  _showAddDialog, 
      ),
    );

      
  }
}
import 'package:PetsCare/widgetsCitas/custom_buttom.dart';
import 'package:PetsCare/widgetsCitas/custom_date_time_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditEventPage extends StatefulWidget {
  EditEventPage({this.title, this.date, this.time, this.description, this.owner, this.index});
  final String title;
  final String date;
  final String time;
  final String description;
  final String owner;
  final index;
  @override
  _EditEventPageState createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {

  TextEditingController controllerTitle;
  TextEditingController controllerDescription;
  TextEditingController controllerDate;
  TextEditingController controllerTime;

  String _selectedDate = 'Elegir Fecha';
  String _selectedTime = 'Elegir hora';
  String id = "id";
  String newCita;
  String descripcion;

  void _editEvent(){//hacer update
   Firestore.instance.runTransaction((Transaction transaction)async{
     DocumentSnapshot snapshot = await 
      transaction.get(widget.index);
      await transaction.update(snapshot.reference, {
          "title" : newCita,
          "description" : descripcion,
          "date" : _selectedDate,
          "time" : _selectedTime
      });
   });
   Navigator.pop(context);
  }

  Future _pickDate() async{
    DateTime datepick = await showDatePicker(
      context: context, 
      initialDate: new DateTime.now(), 
      firstDate: new DateTime.now().add(Duration(days: -365)), 
      lastDate: new DateTime.now().add(Duration(days: 365)), 
    );

  setState(() {
      if(datepick != null ) setState(() {
        _selectedDate = datepick.toString();
      });
    });
  }

  Future _pickTime() async{
    TimeOfDay timepick = await showTimePicker(
      context: context, 
      initialTime: new TimeOfDay.now()
    );
    setState(() {
        if(timepick != null){
          setState(() {
          _selectedTime = timepick.toString();
        });
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerTitle = new TextEditingController(text: widget.title);
    controllerDescription = new TextEditingController(text: widget.description);

    newCita = widget.title;
    descripcion = widget.description;

  }
  @override
  Widget build(BuildContext context) {
    return Material(
          child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(child: Text("Editar cita.", 
            style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            SizedBox(//cambiae color de textBox
              height: 24,
            ), 
              TextField(// titulo de la cita
                controller: controllerTitle,
                onChanged: (String str){
                  setState(() {
                    newCita = str;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ), 
                  labelText: "Nombre de la cita"
                ),
              ),
               SizedBox(//cambiae color de textBox
              height: 12,
            ),
              TextField(//descripcion de la cita
               controller: controllerDescription,
               onChanged: (String str){
                  setState(() {
                    descripcion = str;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ), 
                  labelText: "Descripción"
                ),
              ),
              SizedBox(//cambiae color de textBox
              height: 12,
            ),
             CustomDateTimePicker(
              icon: Icons.date_range,
              onPressed: _pickDate,
              value: _selectedDate,
            ),
            CustomDateTimePicker(
              icon: Icons.access_time,
              onPressed: _pickTime,
              value: _selectedTime,
            ),
              SizedBox(//cambiae color de textBox
              height: 12,
            ), 
            _actionButton(context)
          ],
        ),
      ),
    );
  }

  Widget _actionButton(BuildContext context) { 
    return Material(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CustomButtom(
                onPressed: (){
                 _editEvent();
                }, 
                buttonText: "Guardar",
                color: Colors.brown[600],
                textColor: Colors.white,
              ),
              CustomButtom(
                onPressed: (){
                  Navigator.of(context).pop();
                }, 
                buttonText: "Cancelar"
              ),
            ],
          ),
    );
  }
}
           
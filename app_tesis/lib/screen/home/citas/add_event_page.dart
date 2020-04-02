import 'package:app_tesis/widgetsCitas/custom_buttom.dart';
import 'package:app_tesis/widgetsCitas/custom_date_time_picker.dart';
import 'package:app_tesis/widgetsCitas/custom_modal_action_button.dart';
import 'package:app_tesis/widgetsCitas/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddEventPage extends StatefulWidget {//53:00
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {

  String _selectedDate = 'Elegir Fecha';
  String _selectedTime = 'Elegir hora';

  String newCita = "";
  String descripcion = "";

  Future _pickDate() async{
    DateTime datepick = await showDatePicker(
      context: context, 
      initialDate: new DateTime.now(), 
      firstDate: new DateTime.now().add(Duration(days: -365)), 
      lastDate: new DateTime.now().add(Duration(days: 365)), 
    );

    if(datepick != null ) setState(() {
      _selectedDate = datepick.toString();
    });
  }

  Future _pickTime() async{
    TimeOfDay timepick = await showTimePicker(
      context: context, 
      initialTime: new TimeOfDay.now()
    );
    if(timepick != null){
      setState(() {
        _selectedTime = timepick.toString();
      });
    }
  }

 void _addData(){//subir a la BD
  Firestore.instance.runTransaction((Transaction transsaction) async{
  CollectionReference reference = Firestore.instance.collection("Citas");
  await reference.add({
        'title' : newCita,
        'description' : descripcion,
        'date' : _selectedDate,
        'time' : _selectedTime
    });
  });

  Navigator.pop(context);

 }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(child: Text("Añadir nueva cita.", 
          style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )),
          SizedBox(//cambiae color de textBox
            height: 24,
          ), 
            TextField(// titulo de la cita
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
    );
  }

  Widget _actionButton(BuildContext context) { 
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CustomButtom(
              onPressed: (){
                _addData();
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
        );
  }
}
           
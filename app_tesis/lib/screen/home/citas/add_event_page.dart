import 'package:app_tesis/widgetsCitas/custom_buttom.dart';
import 'package:app_tesis/widgetsCitas/custom_date_time_picker.dart';
import 'package:app_tesis/widgetsCitas/custom_modal_action_button.dart';
import 'package:app_tesis/widgetsCitas/custom_textfield.dart';
import 'package:flutter/material.dart';

class AddEventPage extends StatefulWidget {
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {

  String _selectedDate = 'Elegir Fecha';
   String _selectedTime = 'Elegir hora';

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
          CustomTextField(labelText: "Nombre de la cita."),
          SizedBox(height: 12),
          CustomTextField(labelText: "Descrición."),
          SizedBox(height: 12),
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
            height: 24,
          ),
          CustomModalActionButton(
            onClose: (){
              Navigator.of(context).pop();
            }, 
            onSave: (){}
          ),
        ],
      ),
    );
  }
}
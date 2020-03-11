import 'package:app_tesis/pcitas/widget/customModelActionButtom.dart';
import 'package:app_tesis/pcitas/widget/custom_fecha_hora_picker.dart';
import 'package:app_tesis/pcitas/widget/custom_textField.dart';
import 'package:flutter/material.dart';

class AddCitas extends StatefulWidget {
  @override
  _AddCitasState createState() => _AddCitasState();
}

class _AddCitasState extends State<AddCitas> {

  String _fechaSeleccionada = 'Elegir fecha';
  String _horaSeleccionada = 'Elegir hora';

  Future _elegirFecha()async{
    DateTime elegirFecha = await showDatePicker(
      context: context, 
      initialDate: new DateTime.now(), 
      firstDate: new DateTime.now().add(Duration(days: -365)), 
      lastDate: new DateTime.now().add(Duration(days: 365)));
    if(elegirFecha != null) setState(() {
      _fechaSeleccionada = elegirFecha.toString();
    });
  }

  Future _elegirHora() async {
    TimeOfDay elegirhora = await showTimePicker(
      context: context, 
      initialTime: new TimeOfDay.now(),
    );

    if (elegirhora != null){
      setState(() {
        _horaSeleccionada = elegirhora.toString();
      });
    }

  }
  
  @override
  Widget build(BuildContext context) {
   return Padding (
        padding: const EdgeInsets.all(24.0),
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Text(
              "Añadir nueva cita", 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          SizedBox(
            height: 24,
          ), 
          CustomTextField(
              labelText: "Nombre de la cita."
          ),
          SizedBox(height: 12),
          CustomTextField(
              labelText: "Descripción."
          ),
          SizedBox(height: 12),
          CustomDateTimePicker(
            icon: Icons.date_range,
            onPressed: _elegirFecha,
            value: _fechaSeleccionada,
          ),
          CustomDateTimePicker(
            icon: Icons.access_time,
            onPressed: _elegirHora,
            value: _horaSeleccionada,
          ),
           SizedBox(
            height: 24,
          ),
           CustomModelActionButtom(
            onClose: (){
              Navigator.of(context).pop();
            },  
            onSave: (){},
          ),
        ]
      ),
    ); 
  }
}
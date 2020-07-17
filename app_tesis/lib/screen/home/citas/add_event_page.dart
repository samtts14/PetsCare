import 'package:PetsCare/widgetsCitas/custom_buttom.dart';
import 'package:PetsCare/widgetsCitas/custom_date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AddEventPage extends StatefulWidget {
  final String email;
  const AddEventPage({Key key, this.email}) : super(key: key);
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {

  String _selectedDate = 'Elegir fecha';
  String _selectedTime = 'Elegir hora';
  String id = "id";
  String newCita = "";
  String descripcion = "";
  String owner = "";

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
   DateTime _dueDate = new DateTime.now();
    String _dateText = 'Elegir fecha';

  Future _pickDate() async{
    DateTime datepick = await showDatePicker(
      context: context, 
      initialDate: _dueDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2060)
    );

    if(datepick != null ) setState(() {
      _selectedDate = datepick.toString();
      _dateText = '${datepick.day}/${datepick.month}/${datepick.year}';
    });
  }

  Future _pickTime() async{
    TimeOfDay timepick = await showTimePicker(
      context: context, 
      initialTime: new TimeOfDay.now()
    );
    if(timepick != null){
      setState(() {
        _selectedTime = "${timepick.hour}:${timepick.minute}";
      });
    }
  }

 void _addData(String owner){//subir a la BD
  Firestore.instance.runTransaction((Transaction transsaction) async{
  CollectionReference reference = Firestore.instance.collection("Citas");
  await reference.add({
        'id' : id,//prueba
        'title' : newCita,
        'description' : descripcion,
        'date' : _dateText,
        'time' : _selectedTime,
        'owner': owner,
        
    });
  });

  Navigator.pop(context);

 }
  
  @override
  Widget build(BuildContext context) {
    return Material(
          child: Padding(
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
              Material(
                child: TextField(// titulo de la cita
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
              ),
               SizedBox(//cambiae color de textBox
              height: 12,
            ),
              Material(
                child: TextField(//descripcion de la cita
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
              ),
              SizedBox(//cambiae color de textBox
              height: 12,
            ),
             CustomDateTimePicker(
              icon: Icons.date_range,
              onPressed: _pickDate,
              value: _dateText
            ),
            CustomDateTimePicker(
              icon: Icons.access_time,
              onPressed: _pickTime,
              value: _selectedTime
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
                onPressed: ()async{
                  final currentUser = await _firebaseAuth.currentUser();
                  String email = currentUser.email.toString();
                  _addData(email);
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
           
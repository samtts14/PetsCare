import 'package:flutter/material.dart';

class CustomDateTimePicker extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String value;

  CustomDateTimePicker({
    @required this.onPressed,
    @required this.icon,
    @required this.value
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
          padding: EdgeInsets.zero,
            onPressed: onPressed,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
            child: Row(
              children: <Widget>[
                Icon(icon, 
                color: Colors.brown[600], size: 30,),
                SizedBox(width:12.0),
                Text(value, style: TextStyle(fontSize:14),
                )
              ],
            ),
          )
        );
  }
}
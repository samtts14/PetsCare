import 'package:petscare/widgetsCitas/custom_buttom.dart';
import 'package:flutter/material.dart';

class CustomModalActionButton extends StatelessWidget {

  final VoidCallback onClose;
  final VoidCallback onSave;

  CustomModalActionButton({
    @required this.onClose,
    @required this.onSave
  });
  @override
  Widget build(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CustomButtom(
              onPressed: onSave,
              color: Colors.brown[600],
              textColor: Colors.white, 
              buttonText: "Guardar"
            ),
            CustomButtom(
              onPressed: onClose, 
              buttonText: "Cerrar",
            ),
          ],
        );
  }
}
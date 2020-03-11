import 'package:app_tesis/pcitas/widget/botonCustom.dart';
import 'package:flutter/material.dart';

class CustomModelActionButtom extends StatelessWidget {

  final VoidCallback onClose;
  final VoidCallback onSave;

  CustomModelActionButtom({
    @required this.onClose,
    @required this.onSave
  });

  @override
  Widget build(BuildContext context) {
    return  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            BotonCustom(
              onPressed: onClose, 
              buttonText: "Cancelar",
            ),
            BotonCustom(
                onPressed: onSave, 
                buttonText: "Guardar",
                color: Theme.of(context).accentColor,
                textColor:  Colors.white,
            ),
          ], 
        );
  }
}
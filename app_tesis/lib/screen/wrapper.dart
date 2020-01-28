
import 'package:app_tesis/screen/authenticate/login2.dart';
import 'package:flutter/material.dart';
import 'package:app_tesis/screen/menu.dart';
import 'package:app_tesis/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    // devuelve el home o el authenticate widget
    if (user == null) {
        return Login2();
    } else {
      return Menu();
    }
  }
}
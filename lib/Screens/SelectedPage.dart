import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/Screens/HomePage.dart';
import 'package:timetracker/Screens/Sign_in.dart';
import 'package:timetracker/Services/Auth.dart';
import 'dart:async';

class SelectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthResult>(context, listen: false);
    return StreamBuilder<User>(
        stream: auth.authChangedStat,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            print('Result: ${snapshot.data}');
            if (user == null) {
              return SignIN.create(context);
            }
            print('Result: ${snapshot.data}');
            return HomePage();
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}

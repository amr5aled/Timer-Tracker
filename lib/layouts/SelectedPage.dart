import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/modules/HomePage.dart';
import 'package:timetracker/modules/Sign_in.dart';

import 'package:timetracker/shared/network/remote/Auth.dart';
import 'package:timetracker/shared/network/remote/Database.dart';

class SelectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthResult>(context, listen: false);


    return StreamBuilder<User>(
        // user is object//
        stream: auth.authChangedStat,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            print('Result: ${snapshot.data}');
            if (user == null) {
              return SignIN.create(context);
            }
            print('Result: ${snapshot.data}');
            return Provider<DataBase>(
                create: (_) => FireStoreData(uid: user.uid), child: HomePage());
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

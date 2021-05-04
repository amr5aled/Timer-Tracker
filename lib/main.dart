// package of material//
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/layouts/SelectedPage.dart';
import 'package:timetracker/shared/network/remote/Auth.dart';

// run main method//
void main() async {
  // necassary to initialize to App//
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // create provider to store value and share it date on all widget//
    return Provider<AuthResult>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'TimeTracker',
        debugShowCheckedModeBanner: false, // delete banner on App 'Debug'//
        home: SelectPage(),
      ),
    );
  }
}

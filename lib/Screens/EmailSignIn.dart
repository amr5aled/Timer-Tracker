import 'package:flutter/material.dart';
import 'package:timetracker/Screens/FormSign.dart';

class EmailSign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: buildEmail(),
    );
  }
}

Widget buildEmail() {
  return Padding(padding: EdgeInsets.all(16.0),
    child: Card(
      child: FormSign(),
    ),
  );






}

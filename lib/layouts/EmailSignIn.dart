import 'package:flutter/material.dart';
import 'package:timetracker/layouts/FormSign.dart';

class EmailSign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: buildEmail(context),
    );
  }
}

Widget buildEmail(BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(16.0),
    child: Card(
      child: EmailSignInFormBlocBased.create(context),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/Services/Auth.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
        centerTitle: true,
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(onPressed: () => _confirmSignOut(context), child: Text('Logout'))
        ],
      ),
    );
  }
}

Future<void> _confirmSignOut(BuildContext context) async {
  final auth = Provider.of<AuthResult>(context, listen: false);

  final didRequestSignOut = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure that in logout'),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('OK'),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('cancel'),
            )
          ],
        );
      });
  if (didRequestSignOut == true) {
    auth.sign_out();
  }
}

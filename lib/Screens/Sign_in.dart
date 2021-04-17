import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/Models/CustomRaisedSign.dart';
import 'package:timetracker/Screens/EmailSignIn.dart';
import 'package:timetracker/Services/Auth.dart';

class SignIN extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          'LoginApp',
          style: TextStyle(fontSize: 24.0),
        ),
        centerTitle: true,
      ),
      body: buttonSignIN(context),
      backgroundColor: Colors.white,
    );
  }
}

Future<User> signGoogle(BuildContext context) async {//sign in google//
  try {
    final auth = Provider.of<AuthResult>(context,listen: false);
    await auth.SignInGoogle();
  } on FirebaseException catch (e) {
    print(e.code);
  }
}

Future<User> signFacebook(BuildContext context) async {// sign on facebook//
  try {
    final auth = Provider.of<AuthResult>(context,listen: false);
    await auth.SignInFacebook();
  } on FirebaseException catch (e) {
    print(e.code);
  }
}
void SignEmail(BuildContext context)// sign in email//
{
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (context)=> EmailSign(),
    ),
  );
  
}

Future<User> signanonmous(BuildContext context) async {// anonmous//
  try {
    final auth = Provider.of<AuthResult>(context,listen: false);
    await auth.signAnonymous();
  } on FirebaseException catch (e) {
    print(e.code);
  }
}

Widget buttonSignIN(BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,

      children: <Widget>[
        Image.asset('images/b.jpg',fit: BoxFit.fitHeight,),
        SizedBox(
          height: 10.0,
        ),
        Text(
          'Sign in',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30.0),
        ),
        SizedBox(
          height: 20.0,
        ),
        RasiedButtonSign(
          onPressed: () => signGoogle(context),
          ColorSizeBox: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset('images/google-logo.png'),
              Text(
                'Sign in with Google',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              ),
              Opacity(
                opacity: 0.0,
              )
            ],
          ),
        ),
        SizedBox(height: 12.0),
        RasiedButtonSign(
          onPressed: () => signFacebook(context),
          ColorSizeBox: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset('images/facebook-logo.png'),
              Text(
                'Sign in with Facebook',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              Opacity(
                opacity: 0.0,
              )
            ],
          ),
        ),
        SizedBox(height: 12.0),
        RasiedButtonSign(
          onPressed: () => SignEmail( context),
          ColorSizeBox: Colors.teal,
          child: Text(
            'Sign in with Email',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          'or',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: Colors.black87),
        ),
        SizedBox(
          height: 10.0,

        ),
        RasiedButtonSign(
          onPressed: () => signanonmous(context),
          ColorSizeBox: Colors.lime[600],
          child: Text(
            'Go anonymous',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.black87),
          ),
        ),
      ],
    ),
  );
}

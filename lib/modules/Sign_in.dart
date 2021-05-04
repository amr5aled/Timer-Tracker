import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/blocloading/blocSign.dart';
import 'package:timetracker/layouts/EmailSignIn.dart';
import 'package:timetracker/shared/components/CustomRaisedSign.dart';
import 'package:timetracker/shared/network/remote/Auth.dart';

class SignIN extends StatelessWidget {
  final BlocSign bloc;

  const SignIN({Key key, this.bloc}) : super(key: key);
  // statful==provider(bloc)+child statless//
  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthResult>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
        create: (_) => ValueNotifier<bool>(false),
        child: Consumer<ValueNotifier<bool>>(
          builder: (_, isloading, __) => Provider<BlocSign>(
            create: (_) => BlocSign(auth: auth, isloading: isloading),
            child: Consumer<BlocSign>(
              builder: (_, bloc, __) => SignIN(
                bloc: bloc,
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final isloading = Provider.of<ValueNotifier<bool>>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          'TimerTracker',
          style: TextStyle(fontSize: 24.0),
        ),
        centerTitle: true,
      ),
      body: buttonSignIN(context, isloading.value),
      backgroundColor: Colors.white,
    );
  }

  Widget buttonSignIN(BuildContext context, bool isloading) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/b.jpg',
              fit: BoxFit.fitWidth,
            ),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              child: _buildHeader(isloading),
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
              onPressed: () => SignEmail(context),
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
              onPressed: () => signAnonymous(context),
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
      ),
    );
  }

  Future<void> signAnonymous(BuildContext context) async {
    //sign in Anonymous//
    try {
      await bloc.signAnonymous();
    } on FirebaseException catch (e) {
      print(e.code);
    }
  }

  Future<void> signFacebook(BuildContext context) async {
    // sign on facebook//
    try {
      await bloc.SignInFacebook();
    } on FirebaseException catch (e) {
      print(e.code);
    }
  }

  Future<void> signGoogle(BuildContext context) async {
    // anonmous//
    try {
      await bloc.SignInGoogle();
    } on FirebaseException catch (e) {
      print(e.code);
    }
  }

  void SignEmail(BuildContext context) // sign in email//
  {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => EmailSign(),
      ),
    );
  }
}

Widget _buildHeader(bool isLoading) {
  print('isloading:$isLoading');
  if (!isLoading) {
    return Text(
      'Sign in',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.w600,
      ),
    );
  } else {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

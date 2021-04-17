import 'package:email_validator/email_validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/Services/Auth.dart';

enum EmailSignInFormType { signIn, register }

class FormSign extends StatefulWidget {
  @override
  _FormSignState createState() => _FormSignState();
}

class _FormSignState extends State<FormSign> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  String get _email => emailController.text;
  String get _password => passwordController.text;
  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  bool _submitted = false;
  bool _isLoading = false;
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _toggleFormType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    emailController.clear();
    passwordController.clear();
  }

  void _submit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      final auth = Provider.of<AuthResult>(context, listen: false);
      if (_formType == EmailSignInFormType.signIn) {
        await auth.signWithEmail(_email, _password);
      } else {
        await auth.createWithEmail(_email, _password);
      }
      Navigator.of(context).pop();
    } on FirebaseException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Sign in failed'),
              content: Text(e.message),
              actions: <Widget>[
                FloatingActionButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                )
              ],
            );
          });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextFormField(
          controller: emailController,
          validator: (val) =>
              !EmailValidator.Validate(val, true) ? 'Not a valid email.' : null,
          decoration: InputDecoration(
            labelText: 'Email',
            hintStyle: TextStyle(color: Colors.grey),
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
        ),
        TextFormField(
          controller: passwordController,
          validator: (val) => val.length < 4 ? 'Password too short..' : null,
          obscureText: true,
          decoration: InputDecoration(
           labelText: 'password'
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        // ignore: deprecated_member_use
        SizedBox(
          height: 40.0,
          // ignore: deprecated_member_use
          child: RaisedButton(
            onPressed: _submit,
            color: Colors.indigo,
            child: Text(primaryText),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        // ignore: deprecated_member_use
        FlatButton(onPressed: _toggleFormType, child: Text(secondaryText))
      ],
    );
  }
}

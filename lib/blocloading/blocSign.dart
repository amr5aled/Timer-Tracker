import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timetracker/shared/network/remote/Auth.dart';

class BlocSign {
  BlocSign({this.isloading, this.auth});
  final AuthResult auth;
  final ValueNotifier<bool> isloading;

  Future<User> signIn(Future<User> Function() SignINMethod) async {
    try {
      isloading.value = true;
      return await SignINMethod();
    } catch (e) {
      isloading.value = false;
      rethrow;
    }
  }

  Future<User> signAnonymous() async => await signIn(auth.signAnonymous);
  Future<User> SignInGoogle() async => await signIn(auth.SignInGoogle);
  Future<User> SignInFacebook() async => await signIn(auth.SignInFacebook);
}

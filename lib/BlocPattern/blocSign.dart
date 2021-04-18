import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:timetracker/Services/Auth.dart';

class BlocSign {
   final AuthResult auth;
  StreamController<bool> is_loading = StreamController<bool>();

  BlocSign({this.auth});
  Stream<bool> get is_loadingStream =>
      is_loading.stream; //take istance of is loading//
  void dispose() {
    is_loading.close();
  }
  void SetIsloading(bool isloaading) => is_loading.add(isloaading);

  Future<User> signIn(Future<User>Function()SignINMethod) async {
    try {
      SetIsloading(true);
     return await SignINMethod();
    }catch(e)
    {
      SetIsloading(false);
      rethrow;
    }
  }
  Future<User> signAnonymous()async=>await signIn(auth.signAnonymous );
  Future<User> SignInGoogle()async=>await signIn(auth.SignInGoogle);
  Future<User> SignInFacebook()async=>await signIn(auth.SignInFacebook );
}

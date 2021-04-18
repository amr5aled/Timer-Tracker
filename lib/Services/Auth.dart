import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthResult {
  //no implement method//
  User get CurrentUser;

  Future<void> sign_out();
  Stream<User> get authChangedStat;
  Future<User> signAnonymous();
  Future<User> SignInGoogle();
  Future<User> SignInFacebook();
  Future<User> signWithEmail(String email, String pass);
  Future<User> createWithEmail(String email, String pass);
}

class Auth implements AuthResult {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  User get CurrentUser => _firebaseAuth.currentUser; // check user sign or not
  @override
  Future<User> signAnonymous() async {
    await Firebase.initializeApp(); // start firebase//
    final authResult = await _firebaseAuth.signInAnonymously();
    return (authResult.user);
  }

  @override
  Stream<User> get authChangedStat {
    // sign or not
    Firebase.initializeApp();
    return _firebaseAuth.authStateChanges();
  }

  @override
  //sign in google//
  Future<User> SignInGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn(); // object of
    GoogleSignInAccount googleSignInAccount =
        await googleSignIn.signIn(); // google account//
    if (googleSignInAccount != null) {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      if (googleSignInAuthentication.idToken != null) {
        final authRes = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: googleSignInAuthentication.idToken, // id connect user
                accessToken: googleSignInAuthentication
                    .accessToken)); // to access google service
        return authRes.user;
      } else {
        FirebaseAuthException(code: 'sign is abort by id token');
      }
    } else {
      throw FirebaseAuthException(
          code: 'aborted by user', message: 'sign is abort by user');
    }
  }
  //sign in with facebook//

  @override
  Future<User> SignInFacebook() async {
    final facebookLogin = FacebookLogin();
    final respone = await facebookLogin.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email
    ]);
    switch (respone.status) {
      case FacebookLoginStatus.success:
        final accessToken = respone.accessToken;
        final Res = await _firebaseAuth.signInWithCredential(
            FacebookAuthProvider.credential(accessToken.token));
        return Res.user;
      case FacebookLoginStatus.cancel:
        throw FirebaseAuthException(
            code: 'aborted by user', message: 'sign is abort by user');

      case FacebookLoginStatus.error:
        throw FirebaseAuthException(
            code: 'failed by user', message: respone.error.developerMessage);

      default:
        throw FirebaseAuthException(code: 'failed by user', message: 'error');
    }
  }

  @override
  Future<User> signWithEmail(String email, String pass) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.toString().trim(), password: pass.toString().trim());
    return authResult.user;
  }

  @override
  Future<User> createWithEmail(String email, String pass) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.toString().trim(), password: pass.toString().trim());
    return authResult.user;
  }

// signout//
  @override
  Future<void> sign_out() async {
    print('1');
    Firebase.initializeApp();
    GoogleSignIn googleSignIn = GoogleSignIn();
    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    await googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}

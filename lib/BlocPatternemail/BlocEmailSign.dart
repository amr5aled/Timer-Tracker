import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:timetracker/BlocPatternemail/EmailSignNotify.dart';
import 'package:timetracker/shared/network/remote/Auth.dart';

class EmailSignInBloc {
  EmailSignInBloc({@required this.auth});
  final AuthResult auth;

  final StreamController<EmailSignInNotify> _modelController =
      StreamController<EmailSignInNotify>();
  Stream<EmailSignInNotify> get modelStream =>
      _modelController.stream; // instance of bloc//

  void dispose() {
    _modelController.close();
  }
}

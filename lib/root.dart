import 'package:flutter/material.dart';
import 'package:flutterapp/login_page.dart';
import 'package:flutterapp/screens/loading_screen.dart';
import 'auth.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;
  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus { notSignedIn, signedIn }

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;
  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {});
      authStatus =
          userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
    });
  }

  void signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return LoginPage(
          auth: widget.auth,
          onSignedIn: signedIn,
        );
      case AuthStatus.signedIn:
        return LoadingScreen();
    }
  }
}

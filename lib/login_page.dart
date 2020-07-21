import 'package:flutter/material.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();

  String email;
  String password;
  FormType formType = FormType.login;
  bool validateAndSave() {
    final form = formKey.currentState;
    form.save();
    if (form.validate())
      return true;
    else
      return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (formType == FormType.login) {
          String userId =
              await widget.auth.signInWithEmailAndPassword(email, password);
//          FirebaseUser user = (await FirebaseAuth.instance
//                  .signInWithEmailAndPassword(email: email, password: password))
//              .user;
          print('Signed in:$userId');
        } else {
          String userId =
              await widget.auth.createUserWithEmailAndPassword(email, password);
          print('Signed in:$userId');
//          FirebaseUser newUser = (await FirebaseAuth.instance
//                  .createUserWithEmailAndPassword(
//                      email: email, password: password))
//              .user;

        }
        widget.onSignedIn();
      } catch (e) {
        print('Error $e');
      }
    }
  }

  void getRegister() {
    formKey.currentState.reset();
    setState(() {
      formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: buildInputs() + buildButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Email'),
        validator: (value) => value.isEmpty ? "Email cannot be empty" : null,
        onSaved: (value) => email = value,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Password'),
        obscureText: true,
        validator: (value) => value.isEmpty ? "Password cannot be empty" : null,
        onSaved: (value) => password = value,
      ),
    ];
  }

  List<Widget> buildButtons() {
    if (formType == FormType.login) {
      return [
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          onPressed: () {
            validateAndSubmit();
          },
          color: Colors.blueAccent[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Text(
            "Login",
            style: TextStyle(fontSize: 17.0, color: Colors.white),
          ),
        ),
        FlatButton(
          color: Colors.blueAccent[200],
          child: Text(
            "Create an account",
            style: TextStyle(fontSize: 17.0, color: Colors.white),
          ),
          onPressed: () {
            getRegister();
          },
        ),
      ];
    } else {
      return [
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          onPressed: () {
            validateAndSubmit();
          },
          color: Colors.blueAccent[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Text(
            "Create an account",
            style: TextStyle(fontSize: 17.0, color: Colors.white),
          ),
        ),
        FlatButton(
          onPressed: () {
            moveToLogin();
          },
          color: Colors.blueAccent[200],
          child: Text(
            "Have an account? Login",
            style: TextStyle(fontSize: 17.0, color: Colors.white),
          ),
        ),
      ];
    }
  }
}

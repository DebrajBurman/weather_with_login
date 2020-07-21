import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/screens/loading_screen.dart';
import 'login_page.dart';
import 'auth.dart';
import 'root.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GetWeather',
      home: RootPage(
        auth: Auth(),
      ),
    );
  }
}

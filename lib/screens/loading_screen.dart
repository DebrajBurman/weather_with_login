import 'location_screen.dart';
import 'package:flutterapp/services/weather.dart';
import 'package:flutter/material.dart';

import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apikey = '5fbfc6e8d09c78d0b414285979fdd51f';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.blue,
        ),
      ),
    );
  }
}

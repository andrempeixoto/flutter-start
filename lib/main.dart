import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'GetLocation.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  String apiKey = '89620f59dd863a99889ef3edab81b38d';

  @override
  Widget build(BuildContext context) {
    getLocation();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Weather App',
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: displayImage(), //Image.asset('images/dayTime.jpg')
            ),
            SizedBox(height: 30.0),
            Container(
              // margin: EdgeInsets.only(top: 30.0), // using SizedBox instead
              child: Text(
                'You are in:',
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[500],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text('Pres. Prudente',
                        style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40.0,
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 17.0, horizontal: 25.0),
                    color: Colors.white,
                    child: ListTile(
                      leading: Icon(
                        Icons.wb_sunny,
                        color: Colors.amber,
                      ),
                      title: Text('Temp: 27 ºC'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Display images based on current time
  displayImage() {
    var now = DateTime.now();
    final currentTime = DateFormat.jm().format(now);

    if (currentTime.contains('AM')) {
      return Image.asset('images/dayTime.jpg');
    } else if (currentTime.contains('PM')) {
      return Image.asset('images/nightTime.jpg');
    }
  }

  void getLocation() async {
    GetLocation getlocation = GetLocation();
    await getlocation.getCurrentLocation();

    getTemperature(getlocation.latitude, getlocation.longitude);
  }

  // Get current temperature
  Future<void> getTemperature(double lat, double lon) async {
    http.Response response =
        await http.get('api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey');

    var decodedData = jsonDecode(response.body);
    var description = decodedData['weather'][0]['description'];
    var temperature = decodedData['weather']['temp'];
  }
}

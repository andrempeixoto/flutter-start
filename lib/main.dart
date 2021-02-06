import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'GetLocation.dart';
import './utils/globals.dart' as globals;

void main() => runApp(WeatherApp());

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  String apiKey = globals.apiKey;
  var description;
  var temperature;
  var city;

  @override
  Widget build(BuildContext context) {
    // getLocation();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //     'Weather App',
        //   ),
        // ),
        body: Column(
          children: <Widget>[
            Container(
              child: displayImage(), //Image.asset('images/dayTime.jpg')
            ),
            SizedBox(height: 20.0),
            Container(
              // margin: EdgeInsets.only(top: 30.0), // using SizedBox instead
              child: Text(
                'You are in: ',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[500],
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      city.toString(),
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[500],
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 17.0, horizontal: 25.0),
              color: Colors.white,
              child: ListTile(
                leading: Icon(
                  Icons.device_thermostat,
                  color: setTempIconColor(temperature),
                ),
                title: Text(
                  'Temperature: ${temperature.toString()} ºC',
                ),
                subtitle: Text(description.toString()),
              ),
            ),
            Container(
              child: Center(
                child: FlatButton(
                  child: Text('Get weather info'),
                  color: Colors.blue[500],
                  textColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      getLocation();
                    });
                  },
                ),
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

  // Get location
  void getLocation() async {
    GetLocation getlocation = GetLocation();
    await getlocation.getCurrentLocation();

    print(getlocation.latitude);
    print(getlocation.longitude);
    // print(getlocation.city);

    // city = getlocation.city;

    getTemperature(getlocation.latitude, getlocation.longitude);
  }

  // Get current temperature
  Future<void> getTemperature(double lat, double lon) async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric');
    print(response.body);

    var decodedData = jsonDecode(response.body);
    description = decodedData['weather'][0]['description'];
    temperature = decodedData['main']['temp'];
    city = decodedData['name'];
    print(temperature);
    print(city);
  }

  // Set thermostat icon color
  setTempIconColor(temperature) {
    if (temperature >= 30) {
      return Colors.red;
    } else if (temperature <= 29 && temperature >= 20) {
      return Colors.amber;
    } else if (temperature <= 19 && temperature >= 10) {
      return Colors.green;
    } else if (temperature <= 9 && temperature > 0) {
      return Colors.blue;
    } else if (temperature <= 0) {
      return Colors.blue[200];
    }
  }
}

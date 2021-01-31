import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: displayImage(),
            ),
            // SizedBox(height: 30.0), // not using this element as Container margin is used below
            Container(
              margin: EdgeInsets.only(top: 30.0),
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

  // display images based on current time
  displayImage() {
    var now = DateTime.now();
    final currentTime = DateFormat.jm().format(now);

    if(currentTime.contains('AM')) {
      return Image.asset('images/dayTime.jpg');
    } else if(currentTime.contains('PM')) {
      return Image.asset('images/nightTime.jpg');
    }

    }
  }
}

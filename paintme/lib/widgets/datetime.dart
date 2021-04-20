import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class DateTimeWidget extends StatefulWidget {
  const DateTimeWidget({Key key, this.hasTime = false})
      : assert(hasTime != null),
        super(key: key);

  final bool hasTime;

  @override
  _DateTimeWidgetState createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  String _dateString;
  String _dayOfWeek;
  Position _position;

  final Map<int, String> _weekdayStrings = {
    1: '월요일',
    2: '화요일',
    3: '수요일',
    4: '목요일',
    5: '금요일',
    6: '토요일',
    7: '일요일',
  };

  @override
  void initState() {
    super.initState();
    _getDate();
    _getPosition().then((position) => setState(() {
          _position = position;
        }));
  }

  void _getDate() {
    final DateTime now = DateTime.now();
    final String formattedDate =
        DateFormat('yyyy년\nMM월\ndd일').format(now).toString();
    final int weekday = now.weekday;

    setState(() {
      _dateString = formattedDate;
      _dayOfWeek = _weekdayStrings[weekday];
    });
  }

  Future<Position> _getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> getWeatherData({
    String lat,
    String lon,
  }) async {
    var url = Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_openweatherkey&units=metric');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = response.body;
      var dataJson = jsonDecode(data); // string to json
      print('data = $data');
      print('${dataJson['main']['temp']}');
    } else {
      print('response status code = ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _dateString.toString(),
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.headline5,
        ),
        SizedBox(height: 8),
        Text(
          _dayOfWeek,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.headline5,
        ),
      ],
    );
  }
}

// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;

// class DateTimeWidget extends StatefulWidget {
//   const DateTimeWidget({Key key, this.hasTime = false})
//       : assert(hasTime != null),
//         super(key: key);

//   final bool hasTime;

//   @override
//   _DateTimeWidgetState createState() => _DateTimeWidgetState();
// }

// class _DateTimeWidgetState extends State<DateTimeWidget> {
//   String _dateString;
//   String _dayOfWeek;
//   Position _position;

//   final Map<int, String> _weekdayStrings = {
//     1: '월요일',
//     2: '화요일',
//     3: '수요일',
//     4: '목요일',
//     5: '금요일',
//     6: '토요일',
//     7: '일요일',
//   };

//   @override
//   void initState() {
//     super.initState();
//     _getDate();
//     _getPosition();

//     // try {
//     //   var weather = await _getWeatherData(
//     //     lat: _position.latitude.toString(),
//     //     lon: _position.longitude.toString(),
//     //   );
//     // } catch (err) {
//     //   print(err);
//     // }
//   }

//   void _getDate() {
//     final DateTime now = DateTime.now();
//     final String formattedDate =
//         DateFormat('yyyy년\nMM월\ndd일').format(now).toString();
//     final int weekday = now.weekday;

//     setState(() {
//       _dateString = formattedDate;
//       _dayOfWeek = _weekdayStrings[weekday];
//     });
//   }

//   Future<void> _getPosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     var position = await Geolocator.getCurrentPosition();
//     setState(() {
//       _position = position;
//     });
//   }

//   Future<dynamic> _getWeatherData({
//     String lat,
//     String lon,
//   }) async {
//     var url = Uri.https(
//       'api.openweathermap.org',
//       '/data/2.5/weather',
//       {
//         'lat': lat,
//         'lon': lon,
//         'appid': 'ee3be87d1d40e50a14409874f136056b',
//         'units': 'metric',
//       },
//     );
//     print(url);
//     var response = await http.get(url);

//     if (response.statusCode == 200) {
//       var data = response.body;
//       var dataJson = jsonDecode(data); // string to json
//       return dataJson;
//     } else {
//       throw 'response status code = ${response.statusCode}';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_position == null) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             _dateString.toString(),
//             textAlign: TextAlign.start,
//             style: Theme.of(context).textTheme.headline5,
//           ),
//           SizedBox(height: 8),
//           Text(
//             _dayOfWeek,
//             textAlign: TextAlign.start,
//             style: Theme.of(context).textTheme.headline5,
//           ),
//         ],
//       );
//     } else {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             _dateString.toString(),
//             textAlign: TextAlign.start,
//             style: Theme.of(context).textTheme.headline5,
//           ),
//           SizedBox(height: 8),
//           Text(
//             _dayOfWeek,
//             textAlign: TextAlign.start,
//             style: Theme.of(context).textTheme.headline5,
//           ),
//           SizedBox(height: 8),
//           Text(
//             // _position.latitude.toString(),
//             _position.latitude.toString(),
//             textAlign: TextAlign.start,
//             style: Theme.of(context).textTheme.headline5,
//           ),
//         ],
//       );
//     }
//   }
// }

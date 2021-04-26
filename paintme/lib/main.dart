import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paintme/bloc/idea_bloc.dart';
import 'package:paintme/models/idea_repository.dart';

import 'screens/home.dart';
import 'screens/editor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => IdeaRepository(),
      child: BlocProvider(
        create: (context) =>
            IdeaBloc(RepositoryProvider.of<IdeaRepository>(context))
              ..add(IdeaEventFetching()),
        child: MaterialApp(
          theme: ThemeData(
            primaryColor: Colors.teal,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => Home(),
            '/editor': (context) => Editor(),
          },
        ),
      ),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: GridView.builder(gridDelegate: , itemBuilder: itemBuilder)
//       ),
//     );
//   }
// }

// class PhotosListScreen extends StatefulWidget {
//   @override
//   _PhotosListScreenState createState() => _PhotosListScreenState();
// }

// class _PhotosListScreenState extends State<PhotosListScreen> {
//   bool _hasMore;
//   int _pageNumber;
//   bool _error;
//   bool _loading;
//   final int _defaultPhotosPerPageCount = 10;
//   List<Photo> _photos;
//   final int _nextPageThreshold = 5;

//   @override
//   void initState() {
//     super.initState();
//     _hasMore = true;
//     _pageNumber = 1;
//     _error = false;
//     _loading = true;
//     _photos = [];
//     fetchPhotos();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Photos App'),
//       ),
//       body: getBody(),
//     );
//   }

//   Widget getBody() {
//     if (_photos.isEmpty) {
//       if (_loading) {
//         return Center(
//           child: Padding(
//             padding: const EdgeInsets.all(8),
//             child: CircularProgressIndicator(),
//           ),
//         );
//       } else if (_error) {
//         return Center(
//           child: InkWell(
//             onTap: () {
//               setState(() {
//                 _loading = true;
//                 _error = false;
//                 fetchPhotos();
//               });
//             },
//             child: Padding(
//               padding: EdgeInsets.all(16),
//               child: Text('Error while loading photos, tap to try again'),
//             ),
//           ),
//         );
//       }
//     } else {
//       return GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//         ),
//         itemCount: _photos.length + (_hasMore ? 1 : 0),
//         itemBuilder: (context, index) {
//           if (index == _photos.length - _nextPageThreshold) {
//             fetchPhotos();
//           }
//           if (index == _photos.length) {
//             if (_error) {
//               return Center(
//                   child: InkWell(
//                 onTap: () {
//                   setState(() {
//                     _loading = true;
//                     _error = false;
//                     fetchPhotos();
//                   });
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Text("Error while loading photos, tap to try agin"),
//                 ),
//               ));
//             } else {
//               return Center(
//                   child: Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: CircularProgressIndicator(),
//               ));
//             }
//           }
//           final Photo photo = _photos[index];
//           return Image.network(
//             photo.thumbnailUrl,
//             fit: BoxFit.cover,
//             width: double.infinity,
//             // height: 160,
//           );
//           // return Card(
//           //   child: Column(
//           //     crossAxisAlignment: CrossAxisAlignment.stretch,
//           //     children: <Widget>[
//           //       Image.network(
//           //         photo.thumbnailUrl,
//           //         fit: BoxFit.fitWidth,
//           //         width: double.infinity,
//           //         height: 160,
//           //       ),
//           //     ],
//           //   ),
//           // );
//         },
//       );
//     }
//     return Container();
//   }

//   Future<void> fetchPhotos() async {
//     try {
//       final Uri uri = Uri.https(
//         'api.unsplash.com',
//         '/photos',
//         {
//           'page': '$_pageNumber',
//         },
//       );
//       final response = await http.get(
//         uri,
//         headers: {
//           'Authorization':
//               'Client-ID I-HQgSsrDRlMCukVUbEZHeK8MoB1B4biuF5ULcLWN5I',
//         },
//       );
//       List<Photo> fetchedPhotos = Photo.parseList(json.decode(response.body));
//       setState(() {
//         _hasMore = fetchedPhotos.length == _defaultPhotosPerPageCount;
//         _loading = false;
//         _pageNumber = _pageNumber + 1;
//         _photos.addAll(fetchedPhotos);
//       });
//     } catch (e) {
//       setState(() {
//         _loading = false;
//         _error = true;
//       });
//     }
//   }
// }

// class Photo {
//   final String thumbnailUrl;

//   Photo(this.thumbnailUrl);

//   factory Photo.fromJson(Map<String, dynamic> json) {
//     return Photo(json['urls']['small']);
//   }

//   static List<Photo> parseList(List<dynamic> list) {
//     return list.map((i) => Photo.fromJson(i)).toList();
//   }
// }

// import 'package:paintme/screens/today.dart';

// void main() {
//   runApp(
//     PaintmeApp(),
//   );
// }

// class PaintmeApp extends StatelessWidget {
//   const PaintmeApp({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         scaffoldBackgroundColor: const Color(0xFFF0EDE4),
//         fontFamily: 'NotoSansKR',
//         textTheme: TextTheme(
//           headline1: TextStyle(
//               fontSize: 93, fontWeight: FontWeight.w300, letterSpacing: -1.5),
//           headline2: TextStyle(
//               fontSize: 58, fontWeight: FontWeight.w300, letterSpacing: -0.5),
//           headline3: TextStyle(
//               fontSize: 47, fontWeight: FontWeight.normal, letterSpacing: 0),
//           headline4: TextStyle(
//               fontSize: 33, fontWeight: FontWeight.normal, letterSpacing: 0.25),
//           headline5: TextStyle(
//               fontSize: 23, fontWeight: FontWeight.normal, letterSpacing: 0),
//           headline6: TextStyle(
//               fontSize: 19, fontWeight: FontWeight.w700, letterSpacing: 0.15),
//           subtitle1: TextStyle(
//               fontSize: 16, fontWeight: FontWeight.normal, letterSpacing: 0.15),
//           subtitle2: TextStyle(
//               fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0.1),
//           bodyText1: TextStyle(
//               fontSize: 16, fontWeight: FontWeight.normal, letterSpacing: 0.5),
//           bodyText2: TextStyle(
//               fontSize: 14, fontWeight: FontWeight.normal, letterSpacing: 0.25),
//           button: TextStyle(
//               fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 1.25),
//           caption: TextStyle(
//               fontSize: 12, fontWeight: FontWeight.normal, letterSpacing: 0.4),
//           overline: TextStyle(
//               fontSize: 10, fontWeight: FontWeight.normal, letterSpacing: 1.5),
//         ),
//       ),
//       title: 'FriendlyChat',
//       home: TodayScreen(),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RandomPicture extends StatefulWidget {
  @override
  RandomPictureState createState() => RandomPictureState();
}

class RandomPictureState extends State<RandomPicture> {
  late Future<Picture> futurePicture;
  @override
  void initState() {
    super.initState();
    futurePicture = fetchPicture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Random Picture'), leading: Icon(Icons.refresh_sharp)),
        body: Column(children: [
          FutureBuilder<Picture>(
              future: fetchPicture(),
              builder: (context, snapshot) {
                print('snapshot has data  ${snapshot.hasData}');
                if (snapshot.hasData) {
                  return Image.network(snapshot.data!.url);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (!snapshot.hasData) {
                  return Text('Some text, change it to valid');
                }

                // By default, show a loading spinner.
                return CircularProgressIndicator();
              }),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () {
              setState(() {
                futurePicture = fetchPicture();
              });
            },
            child: Text('Next Picture'),
          )
        ]));
  }
}

Future<Picture> fetchPicture() async {
  print('Retrieving pictures');
  final response = await http.get(Uri.parse(
      'https://api.unsplash.com/photos/random?page=1&client_id=luQfARztlMJuYIis_GuxE2voM-HI1clnMPXW_x6X2I0'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON
    final Map<String, dynamic> data = jsonDecode(response.body);
    print(data);
    return Picture(url: data['urls']['small'], description: 'test');
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception
    //throw Exception('Failed to load album');
    print('dummy pictures');
    return Picture(description: 'some description text', url: '');
  }
}

class Picture {
  final String description;
  final String url;

  Picture({required this.description, required this.url});

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(description: json['description'], url: json['urls']['full']);
  }
}

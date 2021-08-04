import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EventStream extends StatefulWidget {
  @override
  EventStreamState createState() => EventStreamState();
}

class EventStreamState extends State<EventStream> {
  final _records = <Record>[];
  late http.Client _client;

  @override
  void initState() {
    super.initState();    
    // _processStream();
    _streamData();
    _records.add(Record(name: "something"));
  }
  _streamData() {
    try {
      _client = http.Client();

      var request = new http.Request("GET", Uri.parse("http://localhost:5000/event-stream"));
      request.headers["Cache-Control"] = "no-cache";
      request.headers["Accept"] = "text/event-stream";

      Future<http.StreamedResponse> response = _client.send(request);

      response.asStream().listen((streamedResponse) {
        print("Received streamedResponse.statusCode:${streamedResponse.statusCode}");
        streamedResponse.stream.listen((data) {
          print("Received data:${utf8.decode(data)}");
          var record = utf8.decode(data).substring(6);
          setState(() {
            _records[0] = Record(name: record);
          });
        });

      });
    } catch (e) {
      print("Error  $e");
    }
  }

  Widget _dynamicView() {
    return Text(_records.map((e) => e.name).join(" "));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Event Stream'), leading: Icon(Icons.refresh_sharp)),
        body: _dynamicView());
  }
}

class Record {
  final String name;

  Record({required this.name});

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(name: json['records']);
  }
}


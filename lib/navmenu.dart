// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:event_stream_app/event-stream.dart';
import 'package:event_stream_app/random_pic.dart';

// Press the Navigation Drawer button to the left of AppBar to show
// a simple Drawer with two items.
class NavDrawerDemo extends StatelessWidget {
  const NavDrawerDemo({required Key key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    _goToRandomPicture() {
    Navigator.pop(context);  
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext buildContext) {
          return RandomPicture();
        }
      )
    );
    }

    _goToEventstream() {
    Navigator.pop(context);  
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext buildContext) {
          return EventStream();
        }
      )
    );
    }
    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text(
        'account user name',
      ),
      accountEmail: Text(
        'account user email',
      ),
      currentAccountPicture: const CircleAvatar(
        child: FlutterLogo(size: 42.0),
      ),
    );
    final drawerItems = ListView(
      children: [
        drawerHeader,
        ListTile(
          title: Text(
            'Random Picture',
          ),
          leading: const Icon(Icons.favorite),
          onTap: _goToRandomPicture,
        ),
        ListTile(
          title: Text(
            'Event Stream'
          ),
          leading: const Icon(Icons.comment),
          onTap: _goToEventstream,
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Navigation Demo',
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Text(
            'Default landing widget here',
          ),
        ),
      ),
      drawer: Drawer(
        child: drawerItems,
      ),
    );
  }
}


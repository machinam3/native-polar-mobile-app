import 'package:flutter/material.dart';

import 'homepage.dart';

Container profileAll = Container(
  child: ListView(
    children: <Widget>[
      profileTop,
      profileOptions,
    ],
  ),
);

Card profileTop = Card(
  color: Colors.grey,
  child: ListTile(
    isThreeLine: true,
    leading: CircleAvatar(
      radius: 30.0,
      backgroundImage: NetworkImage("http://i.pravatar.cc/300"),
    ),
    title: Text('Horse'),
    subtitle: Text('A strong animal'),
  ),
);

Card profileOptions = Card(
  child: Column(
    children: <Widget>[
      ListTile(
        leading: Icon(Icons.email),
        title: Text('Change Email Address'),
        subtitle: Text('A strong animal'),
        ),
      ListTile(
        leading: Icon(Icons.security),
        title: Text('Change Passowrd'),
        subtitle: Text('A strong passowrd ensures security'),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage("http://i.pravatar.cc/300"),
        ),
        title: Text('Personal Information'),
        subtitle: Text('Update your personal information'),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage("http://i.pravatar.cc/300"),
        ),
        title: Text('Job Information'),
        subtitle: Text('Complete Your guide details'),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    ],
  ),
);

enum Departments { Production, Research, Purchasing, Marketing, Accounting }
 
Future<Departments> _asyncSimpleDialog(BuildContext context) async {
  return await showDialog<Departments>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select Departments '),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, Departments.Production);
              },
              child: const Text('Production'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, Departments.Research);
              },
              child: const Text('Research'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, Departments.Purchasing);
              },
              child: const Text('Purchasing'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, Departments.Marketing);
              },
              child: const Text('Marketing'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, Departments.Accounting);
              },
              child: const Text('Accounting'),
            )
          ],
        );
      });}
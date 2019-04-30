import 'package:flutter/material.dart';
import 'personal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'proffession.dart';
import 'package:polar_app/variable.dart';

//import 'profile.dart';
enum Departments { Production, Research, Purchasing, Marketing, Accounting }

class HomePage extends StatefulWidget {
  HomePage({this.guide});
  final String guide;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    // TODO: implement initState
    super.initState();
    personalinfo();
  }

  Future<String> personalinfo() async {
    print('th e guide was $guideid');

    final response =
        await http.post(baseUrl + "guide.php?function=profile", body: {
      "guide": guideid,
    });
    var pdetails = json.decode(response.body);
    print(response.body);

    setState(() {
      firstname = pdetails['firstname'];
      surname = pdetails['surname'];
      lastname = pdetails['lastname'];
      country = pdetails['country'];
      idnumber = pdetails['idnumber'];
      email = pdetails['email'];
      regdate = pdetails['regdate'];
      dob = pdetails['dateob'];
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    /* building up the profile page*/
    Future<String> _emailInputDialog(BuildContext context) async {
      String teamName = '';
      return showDialog<String>(
        context: context,
        barrierDismissible:
            false, // dialog is dismissible with a tap on the barrier
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Change your Email'),
            content: new Column(
              children: <Widget>[
                TextField(
                  autofocus: true,
                  decoration: new InputDecoration(labelText: 'New Email'),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    teamName = value;
                  },
                ),
                TextField(
                  autofocus: true,
                  decoration: new InputDecoration(labelText: 'Confirm Email'),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    teamName = value;
                  },
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop(teamName);
                },
              ),
            ],
          );
        },
      );
    }

    Future<String> _passwordInputDialog(BuildContext context) async {
      String teamName = '';
      return showDialog<String>(
        context: context,
        barrierDismissible:
            false, // dialog is dismissible with a tap on the barrier
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Change Your Password'),
            content: new Column(
              children: <Widget>[
                TextField(
                  autofocus: true,
                  decoration:
                      new InputDecoration(labelText: 'Current Password'),
                  obscureText: true,
                  onChanged: (value) {
                    teamName = value;
                  },
                ),
                TextField(
                  autofocus: true,
                  decoration: new InputDecoration(labelText: 'New Password'),
                  obscureText: true,
                  onChanged: (value) {
                    teamName = value;
                  },
                ),
                TextField(
                  autofocus: true,
                  decoration:
                      new InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  onChanged: (value) {
                    teamName = value;
                  },
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop(teamName);
                },
              ),
            ],
          );
        },
      );
    }

    Card profileTop = Card(
      color: Colors.grey,
      child: ListTile(
          isThreeLine: true,
          leading: CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage("http://i.pravatar.cc/300"),
          ),
          title: Text('$firstname  $surname'),
          subtitle: Text('A strong animal \t email'),
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                splashColor: Colors.red,
                color: Colors.red,
                icon: Icon(Icons.exit_to_app),
                tooltip: 'Logout',
                onPressed: () {},
              ),
              Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
            ],
          )),
    );

    Card profileOptions = Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Change Email Address'),
            subtitle: Text('A strong animal'),
            onTap: () async {
              final String currentTeam = await _emailInputDialog(context);
              print("Current team name is $currentTeam");
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Change Passowrd'),
            subtitle: Text('A strong passowrd ensures security'),
            onTap: () async {
              final String currentTeam = await _passwordInputDialog(context);
              print("Current team name is $currentTeam");
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Personal Information'),
            subtitle: Text('Update your personal information'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PersonalPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.hotel),
            title: Text('Job Information'),
            subtitle: Text('Complete Your guide details'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProffessionPage()),
              );
            },
          ),
        ],
      ),
    );

    Container profileAll = Container(
      child: ListView(
        children: <Widget>[
          profileTop,
          profileOptions,
        ],
      ),
    );
    /* the end*/

    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange,
            flexibleSpace: SafeArea(
              child: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.home)),
                  Tab(icon: Icon(Icons.terrain)),
                  Tab(icon: Icon(Icons.search)),
                  Tab(icon: Icon(Icons.person)),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              profileAll,
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
              Icon(Icons.perm_camera_mic),
            ],
          ),
        ),
      ),
    );
  }
}

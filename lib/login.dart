import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';////
import 'dart:convert';
import 'register.dart';
import 'main.dart';
import 'variable.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      _login();
    }
  }

  Future<List> _login() async {

      final response = await http.post(
          "http://192.168.140.8/polarapp/includes/functions.php?function=guideUser",
          body: {
            "username": _email,
            "password": _password,
          });
      var datauser = json.decode(response.body);
      print(response.body);
      if (datauser['username'] == 'wrong') {
        final snackbar = new SnackBar(
          content: new Text('wrong username/password'),
        );
        scaffoldKey.currentState.showSnackBar(snackbar);
      } else {
        Navigator.pushReplacementNamed(context, '/HomePage');
      }

      guideid = datauser['Gid'];
      setState(() {
        guide = datauser['Gid'];        
      });
      
      return null;

    }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Polar Tours'),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          //mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 50.0),
            Column(
              children: <Widget>[
                Image.asset('assets/images/logo.png', height: 130.0),
                Text('POLAR TOURS')
              ],
            ),
            SizedBox(height: 50.0),
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) =>
                        !val.contains('@') ? 'Invalid Email' : null,
                    onSaved: (val) => _email = val,
                    decoration: InputDecoration(
                      hintText: 'Email Address',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    autofocus: false,
                    obscureText: true,
                    validator: (val) =>
                        val.length < 2 ? 'Password too short' : null,
                    onSaved: (val) => _password = val,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                  RaisedButton(
                    child: new Text('SIGN IN'),
                    onPressed: _submit,
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    splashColor: Colors.redAccent,
                    textColor: Colors.redAccent,
                    elevation: 8,
                  ),
                ],
              ),
            ),
            FlatButton(
              child: Text('Dont have an account? Tap here to register.'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
            ),
            FlatButton(
              child: Text('Forgot Password?'),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}

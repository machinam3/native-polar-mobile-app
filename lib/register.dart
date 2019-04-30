import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:polar_app/login.dart';
import 'dart:convert';
import 'main.dart';

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  String _firstname;
  String _surname;
  String _lastname;
  String _country;
  String _idnumber;
  String _email;
  String _password;
  String _password2;


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
      if (_password != _password2) {
        final snackbar = new SnackBar(
          content: new Text('Password not match'),
        );
        scaffoldKey.currentState.showSnackBar(snackbar);
      } else {
        _register();
      }
      
    }
  }

  Future<List> _register() async {
      var now = new DateTime.now();
      var formatter = new DateFormat('yyyy-MM-dd');
      String formattedDate = formatter.format(now);
      print(formattedDate); // 2016-01-25
    
      final response = await http.post(
          "http://192.168.140.8/polarapp/includes/functions.php?function=addguide",
          body: {
            "firstname": _firstname,
            "lastname": _lastname,
            "surname": _surname,
            "idnumber": _idnumber,
            "email": _email,
            "jobspec": 'guide',
            "country": _country,
            "password": _password,
            "regdate": formattedDate,
          });
      
        final snackbar = new SnackBar(
          content: new Text('Registration successful'),
        );
        scaffoldKey.currentState.showSnackBar(snackbar);
            
      return null;

    }

  @override
  Widget build(BuildContext context) => Scaffold(
    key: scaffoldKey,
      appBar: AppBar(
        title: Text('Guide Registration'),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          //mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.0),
            Column(
              children: <Widget>[
                Image.asset('assets/images/logo.png', height: 80.0),
                Text('POLAR TOURS')
              ],
            ),
            SizedBox(height: 20.0),
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
              autofocus: false,
              keyboardType: TextInputType.text,
              validator: (val) =>
                        !val.isNotEmpty ? 'Fill here' : null,
                    onSaved: (val) => _firstname = val,
              decoration: InputDecoration(
                hintText: 'First Name',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              autofocus: false,
              validator: (val) =>
                        !val.isNotEmpty ? 'Fill here' : null,
                    onSaved: (val) => _lastname = val,
              decoration: InputDecoration(
                hintText: 'Last Name',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              autofocus: false,
              validator: (val) =>
                        !val.isNotEmpty ? 'Fill here' : null,
                    onSaved: (val) => _surname = val,
              decoration: InputDecoration(
                hintText: 'Surname',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              autofocus: false,
              validator: (val) =>
                        !val.contains('@') ? 'Invalid Email' : null,
                    onSaved: (val) => _email = val,
              decoration: InputDecoration(
                hintText: 'Email',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              autofocus: false,
              validator: (val) =>
                        !val.isNotEmpty ? 'Fill here' : null,
                    onSaved: (val) => _country = val,
              decoration: InputDecoration(
                hintText: 'Country',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              autofocus: false,
              keyboardType: TextInputType.number,
              validator: (val) =>
                        !val.isNotEmpty ? 'Fill here' : null,
                    onSaved: (val) => _idnumber = val,
              decoration: InputDecoration(
                hintText: 'ID Number',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              autofocus: false,
              obscureText: true,
              validator: (val) =>
                        !val.isNotEmpty ? 'Fill here' : null,
                    onSaved: (val) => _password = val,
              decoration: InputDecoration(
                hintText: 'Password',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              autofocus: false,
              obscureText: true,
              validator: (val) =>
                        !val.isNotEmpty ? 'Fill here' : null,
                    onSaved: (val) => _password2 = val,
              decoration: InputDecoration(
                hintText: 'Confirm Password',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
               // border: OutlineInputBorder(HomePage1
                   // borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
            RaisedButton(
              child: Text('Register as guide'),
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
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
}

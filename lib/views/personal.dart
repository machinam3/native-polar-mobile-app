import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:polar_app/variable.dart';

class PersonalPage extends StatefulWidget {
  PersonalPage({this.guide});
  final String guide;
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(
            'Personal Information',
            style: TextStyle(
                fontStyle: FontStyle.italic,
                height: 0.5,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text(
                  'First Name',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      height: 0.5,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '$firstname',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              ListTile(
                title: Text(
                  'Last Name',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      height: 0.5,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '$lastname',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              ListTile(
                title: Text(
                  'Surname',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      height: 0.5,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '$surname',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              ListTile(
                title: Text(
                  'ID Number',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      height: 0.5,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '$idnumber',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              ListTile(
                title: Text(
                  'Date of Birth',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      height: 0.5,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '$dob',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              ListTile(
                title: Text(
                  'Gender',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      height: 0.5,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Complete Your guide details',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              ListTile(
                title: Text(
                  'Country',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      height: 0.5,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '$country',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              ListTile(
                title: Text(
                  'Date Registered',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      height: 0.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                subtitle: Text(
                  '$regdate',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ));
  }
}

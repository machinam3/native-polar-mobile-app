import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProffesionPage extends StatefulWidget {
  @override
  _ProffesionPageState createState() => _ProffesionPageState();
}

class _ProffesionPageState extends State<ProffesionPage> {
  File _image;
  String dlicence;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });

    Future<void> _ackAlert(BuildContext context) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Selected Image'),
            content: Center(
              child: _image == null
                  ? new Text('No image selected.')
                  : new Image.file(_image),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    _ackAlert(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Guide Information',
          style: TextStyle(
              fontStyle: FontStyle.italic,
              height: 0.5,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Form(
            child: Column(
              children: <Widget>[
                Card(
                  child: ListTile(                      
                      title: TextField(
                        autofocus: false,
                        decoration: new InputDecoration(labelText: 'New Email'),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          dlicence = value;
                        },
                      ),
                      trailing: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CircleAvatar(
                            child: _image == null
                                ? IconButton(
                                    splashColor: Colors.red,
                                    color: Colors.red,
                                    icon: Icon(Icons.file_upload),
                                    tooltip: 'Logout',
                                    onPressed: getImage,
                                  )
                                : IconButton(
                                    splashColor: Colors.red,
                                    color: Colors.red,
                                    icon: Icon(Icons.check),
                                    tooltip: 'Logout',
                                    onPressed: getImage,
                                  ),
                          ),
                          Text(
                            'Upload copy',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

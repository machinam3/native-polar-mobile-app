import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:polar_app/variable.dart';

class ProffessionPage extends StatefulWidget {
  ProffessionPage({this.guide});
  final String guide;
  @override
  _ProffessionPageState createState() => _ProffessionPageState();
}

class _ProffessionPageState extends State<ProffessionPage> {
  void initState() {
    // TODO: implement initState
    super.initState();
    _guideinfo();
  }

  final scaffoldKey = new GlobalKey<ScaffoldState>();
   var imagevar;
  File _image;
  File _dlicence;
  File _psvlicence;
  File _ppnumber;
  File _gregno;
  File _certification;
  File _recommendation;
  File _cvitae;
  File _goodconduct;
  File _languages;

  Future getImage() async {
    switch (imagevar) {
      case "dlicence":
        var imgdlicence = await ImagePicker.pickImage(source: ImageSource.gallery);
        setState(() {
           _dlicence = imgdlicence;
        });
        _image = _dlicence;
        _ackAlert(context);
        break;
        case "psvlicence":
        var imgpsvlicence = await ImagePicker.pickImage(source: ImageSource.gallery);
        setState(() {
           _psvlicence = imgpsvlicence;
        });
        _image = _psvlicence;
        _ackAlert(context);
        break;
        case "ppnumber":
        var imgppnumber = await ImagePicker.pickImage(source: ImageSource.gallery);
        setState(() {
           _ppnumber = imgppnumber;
        });
        _image = _ppnumber;
        fileName = _image.path.split("/").last;
        _ackAlert(context);
        break;
        case "gregno":
        var imggregno = await ImagePicker.pickImage(source: ImageSource.gallery);
        setState(() {
           _gregno = imggregno;
        });
        _image = _gregno;
        _ackAlert(context);
        break;
        case "certification":
        var imgcertification = await ImagePicker.pickImage(source: ImageSource.gallery);
        setState(() {
           _certification = imgcertification;
        });
        _image = _certification;
        _ackAlert(context);
        break;
        case "recommendation":
        var imgrecommendation = await ImagePicker.pickImage(source: ImageSource.gallery);
        setState(() {
           _recommendation = imgrecommendation;
        });
        _image = _recommendation;
        _ackAlert(context);
        break;
        case "cvitae":
        var imgcvitae = await ImagePicker.pickImage(source: ImageSource.gallery);
        setState(() {
           _cvitae = imgcvitae;
        });
        _image = _cvitae;
        _ackAlert(context);
        break;
        case "goodconduct":
        var imggoodconduct = await ImagePicker.pickImage(source: ImageSource.gallery);
        setState(() {
           _goodconduct = imggoodconduct;
        });
        _image = _goodconduct;
        _ackAlert(context);
        break;
        case "languages":
        var imglanguages= await ImagePicker.pickImage(source: ImageSource.gallery);
        setState(() {
           _languages = imglanguages;
        });
        _image = _languages;
        _ackAlert(context);
        break;
      default:
    }    
  }
  //upload images to folder
  Future _uploadprofile() {
   
   String base64Image = base64Encode(_image.readAsBytesSync());
   //String fileName = _image.path.split("/").last;

   http.post(baseUrl + "functions1.php?function=uploadprofile", body: {
     "Gid": guideid,
     "image": base64Image,
     "name": fileName,
   }).then((res) {
     print(res.statusCode);
   }).catchError((err) {
     print(err);
   });
   
   return _updateDialog(context);
 }

 //upload profile names to db
  Future<String> _guideinfo() async {
    final response =
        await http.post(baseUrl + "guide.php?function=proffession", body: {
      "guide": guideid,
    });
    var profdetails = json.decode(response.body);
    print(response.body);
    if (profdetails == null) {
      _nullAlert(context);
    } else {
      setState(() {
        gregno = profdetails['guideregno'];
        psvlicence = profdetails['psv_licence'];
        dlicence = profdetails['driving_licence'];
        ppnumber = profdetails['passport_no'];
        certification = profdetails['certification'];
        recommendation = profdetails['recomendation'];
        cvitae = profdetails['c_vitae'];
        goodconduct = profdetails['goodconduct'];
        languages = profdetails['languages'];
      });
    }
    return null;
  } //guide info upload

  Future<String> _guideupload() async {
     final response =
        await http.post(baseUrl + "functions1.php?function=Insert", body: {
      "table": "profiles",
      "Gid": guideid,
      "guideregno": gregno,
      "psv_licence": psvlicence,
      "driving_licence": dlicence,
      "passport_no": ppnumber,
      "certification": certification,
      "recommendation": recommendation,
      "c_vitae": cvitae,
      "goodconduct": goodconduct,
      "languages": languages,
    });
    print('this is the');
    print(response.body);

    return null;
  }

  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selected Image'),
          content: Center(
            child: _image== null
                ? new Text('No image selected.')
                : new Image.file(_image),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () async{
                 _image== null
                ? Navigator.of(context).pop()
                : _uploadprofile();                
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _nullAlert(BuildContext context) {
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

  Future<String> _updateDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Your Details'),
          content:TextField(
                autofocus: true,
                decoration: new InputDecoration(labelText: 'Document No/issuer'),
                onChanged: (value) {
                  switch (updateitem) {
                    case 'gregno':
                      gregno = value;
                      break;
                    case 'psvlicence':
                      psvlicence = value;
                      break;
                    case 'dlicence':
                      dlicence = value;
                      break;
                    case 'ppnumber':
                      ppnumber = value;
                      break;
                    case 'certification':
                      certification = value;
                      break;
                    case 'recommendation':
                      recommendation = value;
                      break;
                    case 'cvitae':
                      cvitae = value;
                      break;
                    case 'goodconduct':
                      goodconduct = value;
                      break;
                    case 'languages':
                      languages = value;
                      break;
                    default:
                  }
                },
              ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop(updateitem);
              },
            ),
          ],
        );
      },
    );
  }

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
      body: ListView(
        children: <Widget>[
          ListTile(
              title: Text(
                'Driving Licence No.',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    height: 0.5,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '$dlicence',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () async {
                updateitem = 'dlicence';
                final String wait = await _updateDialog(context);
              },
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircleAvatar(
                    child: _dlicence == null
                        ? IconButton(
                            splashColor: Colors.red,
                            color: Colors.red,
                            icon: Icon(Icons.file_upload),
                            tooltip: 'Logout',
                            onPressed: () async {imagevar = 'dlicence';
                            final String image = await getImage();
                          
                            },
                          )
                        : IconButton(
                            splashColor: Colors.red,
                            color: Colors.red,
                            icon: Icon(Icons.check),
                            tooltip: 'Logout',
                            onPressed: () async {imagevar = 'dlicence';
                            final String image = await getImage();
                            },
                          ),
                  ),
                  Text(
                    'Upload copy',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              )),
          Divider(
            color: Colors.black,
          ),
          ListTile(
              title: Text(
                'PSV licence No.',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    height: 0.5,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '$psvlicence',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () async {
                updateitem = 'psvlicence';
                final String wait = await _updateDialog(context);
              },
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircleAvatar(
                    child: _psvlicence == null
                        ? IconButton(
                            splashColor: Colors.red,
                            color: Colors.red,
                            icon: Icon(Icons.file_upload),
                            tooltip: 'Logout',
                            onPressed: () async {imagevar = 'psvlicence';
                            final String image = await getImage();
                            },
                          )
                        : IconButton(
                            splashColor: Colors.red,
                            color: Colors.red,
                            icon: Icon(Icons.check),
                            tooltip: 'Logout',
                            onPressed: () async {imagevar = 'psvlicence';
                            final String image = await getImage();
                            },
                          ),
                  ),
                  Text(
                    'Upload copy',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              )),
              Divider(
            color: Colors.black,
          ),
          ListTile(
              title: Text(
                'Passport Number',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    height: 0.5,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '$ppnumber',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () async {
                updateitem = 'ppnumber';
                final String wait = await _updateDialog(context);
              },
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircleAvatar(
                    child: _ppnumber == null
                        ? IconButton(
                            splashColor: Colors.red,
                            color: Colors.red,
                            icon: Icon(Icons.file_upload),
                            tooltip: 'Logout',
                            onPressed: () async {imagevar = 'ppnumber';
                            final String image = await getImage();
                            },
                          )
                        : IconButton(
                            splashColor: Colors.red,
                            color: Colors.red,
                            icon: Icon(Icons.check),
                            tooltip: 'Logout',
                            onPressed: () async {imagevar = 'ppnumber';
                            final String image = await getImage();
                            },
                          ),
                  ),
                  Text(
                    'Upload copy',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              )),
              Divider(
            color: Colors.black,
          ),
          ListTile(
              title: Text(
                'Your guide reg number',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    height: 0.5,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '$gregno',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () async {
                updateitem = 'gregno';
                final String wait = await _updateDialog(context);
              },
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircleAvatar(
                    child: _gregno == null
                        ? IconButton(
                            splashColor: Colors.red,
                            color: Colors.red,
                            icon: Icon(Icons.file_upload),
                            tooltip: 'Logout',
                            onPressed: () async {imagevar = 'gregno';
                            final String image = await getImage();
                            },
                          )
                        : IconButton(
                            splashColor: Colors.red,
                            color: Colors.red,
                            icon: Icon(Icons.check),
                            tooltip: 'Logout',
                            onPressed: () async {imagevar = 'gregno';
                            final String image = await getImage();
                            },
                          ),
                  ),
                  Text(
                    'Upload copy',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              )),
              Divider(
            color: Colors.black,
          ),
          ListTile(
              title: Text(
                'Guide Certification',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    height: 0.5,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '$certification',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () async {
                updateitem = 'certification';
                final String wait = await _updateDialog(context);
              },
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircleAvatar(
                    child: _certification == null
                        ? IconButton(
                            splashColor: Colors.red,
                            color: Colors.red,
                            icon: Icon(Icons.file_upload),
                            tooltip: 'Logout',
                            onPressed: () async {imagevar = 'certification';
                            final String image = await getImage();
                            },
                          )
                        : IconButton(
                            splashColor: Colors.red,
                            color: Colors.red,
                            icon: Icon(Icons.check),
                            tooltip: 'Logout',
                            onPressed: () async {imagevar = 'certification';
                            final String image = await getImage();
                            },
                          ),
                  ),
                  Text(
                    'Upload copy',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              )),
              Divider(
            color: Colors.black,
          ),
          ListTile(
              title: Text(
                'Recommendation letter',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    height: 0.5,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '$recommendation',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () async {
                updateitem = 'recommendation';
                final String wait = await _updateDialog(context);
              },
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircleAvatar(
                    child: _recommendation == null
                        ? IconButton(
                            splashColor: Colors.red,
                            color: Colors.red,
                            icon: Icon(Icons.file_upload),
                            tooltip: 'Logout',
                            onPressed: () async {imagevar = 'recommendation';
                            final String image = await getImage();
                            },
                          )
                        : IconButton(
                            splashColor: Colors.red,
                            color: Colors.red,
                            icon: Icon(Icons.check),
                            tooltip: 'Logout',
                            onPressed: () async {imagevar = 'recommendation';
                            final String image = await getImage();
                            },
                          ),
                  ),
                  Text(
                    'Upload copy',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              )),
              Divider(
            color: Colors.black,
          ),
          ListTile(
              title: Text(
                'CV',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    height: 0.5,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '$cvitae',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () async {
                updateitem = 'cvitae';
                final String wait = await _updateDialog(context);
              },
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircleAvatar(
                    child: _cvitae == null
                        ? IconButton(
                            splashColor: Colors.red,
                            color: Colors.red,
                            icon: Icon(Icons.file_upload),
                            tooltip: 'Logout',
                            onPressed: () async {imagevar = 'cvitae';
                            final String image = await getImage();
                            },
                          )
                        : IconButton(
                            splashColor: Colors.red,
                            color: Colors.red,
                            icon: Icon(Icons.check),
                            tooltip: 'Logout',
                            onPressed: () async {imagevar = 'cvitae';
                            final String image = await getImage();
                            },
                          ),
                  ),
                  Text(
                    'Upload pdf',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              )),
              Divider(
            color: Colors.black,
          ),
          ListTile(
              title: Text(
                'GoodConduct Certificate',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    height: 0.5,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '$goodconduct',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () async {
                updateitem = 'goodconduct';
                final String wait = await _updateDialog(context);
              },
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircleAvatar(
                    child: _goodconduct == null
                        ? IconButton(
                            splashColor: Colors.red,
                            color: Colors.red,
                            icon: Icon(Icons.file_upload),
                            tooltip: 'Logout',
                            onPressed: () async {imagevar = 'goodconduct';
                            final String image = await getImage();
                            },
                          )
                        : IconButton(
                            splashColor: Colors.red,
                            color: Colors.red,
                            icon: Icon(Icons.check),
                            tooltip: 'Logout',
                            onPressed: () async {imagevar = 'goodconduct';
                            final String image = await getImage();
                            },
                          ),
                  ),
                  Text(
                    'Upload copy',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              )),
              Divider(
            color: Colors.black,
          ),
          ListTile(
              title: Text(
                'Languages',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    height: 0.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              subtitle: Text(
                '$languages',
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () async {
                updateitem = 'languages';
                final String wait = await _updateDialog(context);
              },
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircleAvatar(
                    child: _languages == null
                        ? IconButton(
                            splashColor: Colors.red,
                            color: Colors.red,
                            icon: Icon(Icons.file_upload),
                            tooltip: 'Logout',
                            onPressed: () async {imagevar = 'languges';
                            final String image = await getImage();
                            },
                          )
                        : IconButton(
                            splashColor: Colors.red,
                            color: Colors.red,
                            icon: Icon(Icons.check),
                            tooltip: 'Logout',
                            onPressed: () async {imagevar = 'languges';
                            final String image = await getImage();
                            },
                          ),
                  ),
                  Text(
                    'Upload copy',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              )),
          RaisedButton(
            child: new Text('UPLOAD UPDATE'),
            onPressed: _guideupload,
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
            splashColor: Colors.redAccent,
            textColor: Colors.redAccent,
            elevation: 8,
          ),
        ],
      ),
    );
  }
}

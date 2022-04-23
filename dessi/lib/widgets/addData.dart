import 'package:dessi/page/sphome.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;
import 'package:firebase_auth/firebase_auth.dart';

class AddContact extends StatefulWidget {
  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  late DatabaseReference _ref;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _detailController = TextEditingController();
    _numberController = TextEditingController();
    _locationController = TextEditingController();
    _ref = FirebaseDatabase.instance.reference().child('contact');
  }

  late TextEditingController _nameController,
      _numberController,
      _locationController,
      _detailController;

  String _typeSelected = '';

  Widget _buildContactType(String title) {
    return InkWell(
      child: Container(
        height: 40,
        width: 90,
        decoration: BoxDecoration(
          color: _typeSelected == title
              ? Colors.green
              : Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      onTap: () {
        setState(() {
          _typeSelected = title;
        });
      },
    );
  }

  String selectedValue = "Select your Location";
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text("Select your Location"), value: "Select your Location"),
      DropdownMenuItem(child: Text("Mumbai"), value: "Mumbai"),
      DropdownMenuItem(child: Text("Delhi"), value: "Delhi"),
      DropdownMenuItem(child: Text("Kolkata"), value: "Kolkata"),
      DropdownMenuItem(child: Text("Chennai"), value: "Chennai"),
      DropdownMenuItem(child: Text("Bhopal"), value: "Bhopal"),
      DropdownMenuItem(child: Text("Pune"), value: "Pune"),
    ];
    return menuItems;
  }

  late String _uploadedFileURL;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Save Contact'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/mlss.png",
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              children: <Widget>[
                Text('Selected Image'),
                RaisedButton(
                  child: Text('Choose File'),
                  onPressed: getImage,
                  color: Colors.cyan,
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter Name',
                      prefixIcon: Icon(
                        Icons.account_circle,
                        size: 30,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.all(15),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _numberController,
                    decoration: InputDecoration(
                      hintText: 'Enter Number',
                      prefixIcon: Icon(
                        Icons.phone_iphone,
                        size: 30,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.all(15),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _detailController,
                    decoration: InputDecoration(
                      hintText: 'Enter Details',
                      prefixIcon: Icon(
                        Icons.chat,
                        size: 70,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.all(15),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DropdownButtonFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.limeAccent, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: Colors.orange),
                      dropdownColor: Colors.lime,
                      value: selectedValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue = newValue!;
                        });
                      },
                      items: dropdownItems),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildContactType('Dairy'),
                        SizedBox(width: 10),
                        _buildContactType('Laundary'),
                        SizedBox(width: 10),
                        _buildContactType('Groceries'),
                        SizedBox(width: 10),
                        _buildContactType('Fruits and Vegetables'),
                        SizedBox(width: 10),
                        _buildContactType('Others'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.redAccent,
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        onPressed: getImage,
                        child: Center(
                          child: Text(
                            'Add Image',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                      ni
                          ? Container(
                              width: 150,
                              height: 150,
                              margin: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: Colors.black,
                                ),
                              ),
                              child: tempim,
                            )
                          : Container(
                              width: 150,
                              height: 150,
                              margin: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: Colors.black,
                                ),
                              ),
                              child: Image.file(
                                File(_image.path),
                                fit: BoxFit.contain,
                              ),
                            ),

                      // Image.file(File(_image.path)),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: RaisedButton(
                      child: Text(
                        'ADD',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        saveContact();
                      },
                      color: Colors.redAccent,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _SaveShow() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Record'),
            content: Text('Are you sure you want to Add Record?'),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              FlatButton(
                  onPressed: () {
                    saveContact();
                  },
                  child: Text('Save'))
            ],
          );
        });
  }

  void saveContact() async {
    String name = _nameController.text;
    String detail = _detailController.text;
    String number = _numberController.text;
    String location = selectedValue;
    String url = await uploadPic(img: _image);

    //   final String fileUrl =
    //      await FirebaseStorage.instance.ref().getDownloadURL();
    Map<String, String> contact = {
      'name': name,
      'detail': detail,
      'number': '+91 ' + number,
      'image': url,
      'type': _typeSelected,
      'location': location,
    };

    _ref.push().set(contact).then((value) {
      Navigator.of(context).pop();
    });
  }

  /* Future uploadFile() async {
    String path = _image.path;

    File imageFile = File(_image.path);

    await FirebaseStorage.instance.ref().putFile(imageFile);
  }*/

  bool ni = true;
  final Image tempim = Image.asset("assets/img.png");
  late XFile _image;
  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    ni = false;
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery).then((image) {
      if (image == null) return null;
      setState(() {
        _image = image;
      });
    });
  }

  static Future<dynamic> uploadPic({required XFile img}) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference reference =
        FirebaseStorage.instance.ref().child(img.path).child(fileName);

    TaskSnapshot storageTaskSnapshot = await reference.putFile(File(img.path));
    // TaskSnapshot storageTaskSnapshot =  uploadTask.snapshot;

    print(storageTaskSnapshot.ref.getDownloadURL());

    var dounloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

    return dounloadUrl;
  }
/*  uploadPic(XFile _image) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Future<String> url;
    Reference ref = storage.ref().child("image1" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(File(_image.path));

    url = ref.getDownloadURL();

    /*uploadTask.whenComplete(() {
      url = ref.getDownloadURL();
    }).catchError((onError) {
      print(onError);
    });*/
    return url;
  }*/
}

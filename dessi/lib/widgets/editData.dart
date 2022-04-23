import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;

class EditContact extends StatefulWidget {
  late String contactKey;
  EditContact({required this.contactKey});

  @override
  _EditContactState createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  late TextEditingController _nameController,
      _numberController,
      _detailController;

  String _typeSelected = '';
  String _location = '';
  late DatabaseReference _ref;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _numberController = TextEditingController();
    _detailController = TextEditingController();

    // _locationController = TextEditingController();
    _ref = FirebaseDatabase.instance.reference().child('contact');
    getContactDetail();
  }

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
            style: TextStyle(fontSize: 18, color: Colors.white),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Contact'),
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
                  onPressed: chooseFile,
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
                  SizedBox(
                    height: 15,
                  ),
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
                        onPressed: chooseFile,
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
                      SingleChildScrollView(
                        child: ni
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
                      ),
                      // Image.file(File(_image.path)),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: RaisedButton(
                      child: Text(
                        'Update Contact',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        saveContact();
                      },
                      color: Theme.of(context).primaryColor,
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

  late String _uploadedFileURL;
  getContactDetail() async {
    DataSnapshot snapshot = await _ref.child(widget.contactKey).once();

    Map contact = snapshot.value;

    _nameController.text = contact['name'];

    _numberController.text = contact['number'];
    _detailController.text = contact['detail'];

    setState(() {
      _location = contact['location'];
      _typeSelected = contact['type'];
      _image = XFile(contact['image']);
    });
  }

  void saveContact() {
    //  String location = ;
    String name = _nameController.text;
    String detail = _detailController.text;
    String number = _numberController.text;
    Map<String, String> contact = {
      'name': name,
      'detail': detail,
      'number': '+91 ' + number,
      'location': _location,
      'image': _image.path,
      'type': _typeSelected,
    };
    _ref.child(widget.contactKey).update(contact).then((value) {
      Navigator.pop(context);
    });
  }

  Future uploadFile() async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('chats/${Path.basename(_image.path)}}');
    UploadTask uploadTask = storageReference.putFile(File(_image.path));
    await uploadTask.whenComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });
    });
  }

  bool ni = true;
  final Image tempim = Image.asset("assets/img.png");
  late XFile _image;
  Future chooseFile() async {
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
}

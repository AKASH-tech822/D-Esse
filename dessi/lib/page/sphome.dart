import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import '../widgets/addData.dart';
import '../widgets/editData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';

class SPHome extends StatefulWidget {
  SPHome({Key? key, required User user})
      : _user = user,
        super(key: key);
  final User _user;

  @override
  _SPHomeState createState() => _SPHomeState();
}

/*Future<void> fetchtheprofiles({required Map contact}) async {
  final response = await http.get(Uri.parse(
      "https://dessi-a845e-default-rtdb.firebaseio.com/contact.json?"));
  print(json.decode(response.body));
  late Map<dynamic, dynamic> loadedContact;
  final extractedData = json.decode(response.body) as Map<String, dynamic>;
  extractedData.forEach((contactId, contactData) {
    loadedContact.toList().add(
      contactData["name"],
      contactData["detail"],
      contactData["image"],
      contactData["number"],
      contactData["type"],
    );
  });
}
*/
class _SPHomeState extends State<SPHome> {
  late User _user;

  late Query _ref;
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('contact');
  @override
  void initState() {
    // TODO: implement initState
    //  fetchtheprofiles();
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('contact')
        .orderByChild('name');
    _user = widget._user;
  }

  Widget _buildContactItem({required Map contact}) {
    Color typeColor = getTypeColor(contact['type']);
    return Flexible(
      child: Container(
        height: 200,
        child: Card(
          color: Colors.white70,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  height: 100,
                  //       child: CachedNetworkImage(
                  //         imageUrl: contact['image'],
                  //      ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(contact['name'],
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Text(contact['detail'],
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Text(contact['number'],
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                          )),
                      Text(contact['location'],
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: Row(children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => EditContact(
                                                  contactKey: contact['key'],
                                                )));
                                  },
                                  child: Expanded(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          color: Colors.green[600],
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Text('Edit',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.green,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _showDeleteDialog(contact: contact);
                                  },
                                  child: Expanded(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          color: Colors.red[700],
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Text('Delete',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.red[700],
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
        ),
      ),
    );
  }

  _showDeleteDialog({required Map contact}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete ${contact['name']}'),
            content: Text('Are you sure you want to delete?'),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              FlatButton(
                  onPressed: () {
                    reference
                        .child(contact['key'])
                        .remove()
                        .whenComplete(() => Navigator.pop(context));
                  },
                  child: Text('Delete'))
            ],
          );
        });
  }

  Widget build(BuildContext context) {
    Map contact;
    return Scaffold(
      drawer: AppDrawer(user: _user),
      appBar: AppBar(
        title: Text(
          'D-Esse',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) {
              return AddContact();
            }),
          );
        },
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
          FirebaseAnimatedList(
            shrinkWrap: true,
            query: _ref,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map contact = snapshot.value;
              contact['key'] = snapshot.key;
              return _buildContactItem(contact: contact);
            },
          ),
        ],
      ),
    );
  }

  Color getTypeColor(String type) {
    Color color = Theme.of(context).accentColor;

    if (type == 'Laundary') {
      color = Colors.brown;
    }

    if (type == 'Dairy') {
      color = Colors.white;
    }

    if (type == 'Groceries') {
      color = Colors.teal;
    }
    if (type == 'Fruits & Vegetables') {
      color = Colors.lightGreen;
    }
    return color;
  }
}

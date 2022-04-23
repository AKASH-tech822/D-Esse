import 'package:dessi/widgets/app_drawer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import './sphome.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:get_it/get_it.dart';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required User user})
      : _user = user,
        super(key: key);
  final User _user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    String num = contact['number'].replaceAll(' ', '');
    Color typeColor = getTypeColor(contact['type']);

    return SingleChildScrollView(
      child: Flexible(
        child: Container(
          height: 250,
          // constraints: BoxConstraints(maxWidth: 600),
          child: Card(
            color: Colors.white70,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    height: 100,
                    width: 100,
                    child: Image.network(contact['image']),
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
                        Text(contact['location'],
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        Row(children: <Widget>[
                          Expanded(
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              child: ElevatedButton(
                                onPressed: () => _service.call(num),
                                /*setState(
                                    () {
                                      _launched = _launchInBrowser("tel:$num");
                                    },
                                  ),*/
                                child: Icon(Icons.phone),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              child: ElevatedButton(
                                onPressed: // () => setState(
                                    () => _service.call(num),
                                //_launched = _launchInBrowser("sms:$num");

                                //   ),
                                child: Icon(Icons.chat),
                              ),
                            ),
                          ),
                        ]),
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
      ),
    );
  }

  /* Route _routeToChat() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ChatScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }*/
  Color getTypeColor(String type) {
    Color color = Colors.lime;

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

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        drawer: AppDrawer(user: _user),
        appBar: AppBar(
          actions: <Widget>[
            DropdownButton(
                elevation: 5,
                value: selectedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                items: dropdownItems),
          ],
          title: Text(
            'D-Esse',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
          centerTitle: true,
          bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.orange,
              indicatorWeight: 6.0,
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  text: 'Home',
                ),
                Tab(
                  icon: Icon(Icons.local_cafe),
                  text: 'Dairy',
                ),
                Tab(
                  icon: Icon(Icons.local_laundry_service_sharp),
                  text: 'Laundary',
                ),
                Tab(
                  icon: Icon(Icons.local_grocery_store),
                  text: 'Groceries',
                ),
                Tab(
                  icon: Icon(Icons.local_florist),
                  text: 'Fruits & Vegetables',
                ),
                Tab(
                  icon: Icon(Icons.search_rounded),
                  text: 'Others',
                ),
              ]),
        ),

        /*  floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.limeAccent,
          foregroundColor: Colors.black,
          child: Icon(Icons.chat),
          onPressed: () => Navigator.of(context).pushReplacement(/*_routeToChat()*/),
        ),*/

        body: TabBarView(
          children: [
            Stack(
              children: [
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
              ],
            ),
            //tab1
            bG(context, "Dairy", selectedValue),
            //tab2
            bG(context, "Laundary", selectedValue),
            //tab3
            bG(context, "Groceries", selectedValue),
            //tab4
            bG(context, "Fruits and Vegetables", selectedValue),
            //tab5
            bG(context, "Others", selectedValue),
          ],
        ),
      ),
    );
  }

  Widget bG(BuildContext context, String st, String lo) {
    return Stack(
      children: [
        SizedBox(
          height: 20,
        ),
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
            if (contact['type'] == st && contact['location'] == lo)
              return _buildContactItem(contact: contact);
            else
              return SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(CallsAndMessagesService());
}

final CallsAndMessagesService _service = locator<CallsAndMessagesService>();

class CallsAndMessagesService {
  void call(String number) => launch("tel:$num");
  void sendSms(String number) => launch("sms:$num");
  //void sendEmail(String email) => launch("mailto:$c");
}

late Future<void> _launched;
Future<void> _launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  } else {
    throw 'Could not launch $url';
  }
}

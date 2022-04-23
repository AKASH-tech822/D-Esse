import 'package:dessi/page/home.dart';
import 'package:dessi/page/singnin_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../res/custom_colors.dart';
import '../util/authentication.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late User _user;

  bool _isSigningOut = false;

  @override
  void initState() {
    _user = widget._user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(_user.displayName!),
            accountEmail: Text(_user.email!),
            currentAccountPicture: Container(
              child: ClipOval(
                child: Material(
                  color: CustomColors.firebaseGrey.withOpacity(0.3),
                  child: Image.network(
                    _user.photoURL!,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Sign Out'),
            onTap: () async {
              setState(() {
                _isSigningOut = true;
              });
              await Authentication.signOut(context: context);
              setState(() {
                _isSigningOut = false;
              });
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignInScreen()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HomePage(
                    user: _user,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

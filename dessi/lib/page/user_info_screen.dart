import 'package:dessi/page/home.dart';
import 'package:dessi/page/sphome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './sphome.dart';
import '../res/custom_colors.dart';
import '../page/singnin_screen.dart';
import '../util/authentication.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  late User _user;
  bool _isSigningOut = false;

  Route _routeToTransactionPage() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => HomePage(
        user: _user,
      ),
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
  }

  Route _routeToSPHome() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          SPHome(user: _user),
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
  }

  @override
  void initState() {
    _user = widget._user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.firebaseNavy,
      appBar: AppBar(
        title: Text(
          'D-Esse',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/bg.png",
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(),
                _user.photoURL != null
                    ? ClipOval(
                        child: Material(
                          color: CustomColors.firebaseGrey.withOpacity(0.3),
                          child: Image.network(
                            _user.photoURL!,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      )
                    : ClipOval(
                        child: Material(
                          color: CustomColors.firebaseGrey.withOpacity(0.3),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Icon(
                              Icons.person,
                              size: 60,
                              color: CustomColors.firebaseGrey,
                            ),
                          ),
                        ),
                      ),
                SizedBox(height: 16.0),
                /*Text(
                  'H e l l o ',
                  style: TextStyle(
                    color: CustomColors.firebaseGrey,
                    backgroundColor: Colors.black54,
                    fontSize: 26,
                  ),
                ),*/
                SizedBox(height: 8.0),
                Text(
                  _user.displayName!,
                  style: TextStyle(
                    color: CustomColors.firebaseYellow,
                    backgroundColor: Colors.black54,
                    fontSize: 26,
                  ),
                ),
                /* SizedBox(height: 8.0),
                Container(
                  color: Colors.black54,
                  child: Text(
                    '( ${_user.email!} )',
                    style: TextStyle(
                      color: CustomColors.firebaseOrange,
                      fontSize: 20,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),*/
                SizedBox(height: 24.0),
                Card(
                  color: Colors.white30,
                  margin: EdgeInsets.all(4),
                  semanticContainer: true,
                  elevation: 4,
                  child: Center(
                    child: Text(
                      'Welcome to D-Esse Click Button Below to Enter the App :',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          letterSpacing: 0.2),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.lime,
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () => Navigator.of(context)
                      .pushReplacement(_routeToTransactionPage()),
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      'Customer',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                /*Container(
                  color: Colors.black54,
                  child: Text(
                    'You are now signed in using your Google account. To sign out of your account click the "Sign Out" button below.',
                    style: TextStyle(
                        color: Colors.white, fontSize: 17, letterSpacing: 0.2),
                  ),
                ),
                SizedBox(height: 16.0),
                _isSigningOut
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : */
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.lime,
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () =>
                      Navigator.of(context).pushReplacement(_routeToSPHome()),
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      'Service Provider',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

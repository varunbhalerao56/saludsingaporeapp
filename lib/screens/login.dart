import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:saludsingapore/helpers/export_helper.dart';
import 'package:saludsingapore/screens/main_screen.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _usernameControl = new TextEditingController();
  final TextEditingController _passwordControl = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0,0,20,0),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[

            SizedBox(height: 10.0),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                top: 25.0,
              ),
              child: Text(
                "Log in to your account",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),

            SizedBox(height: 30.0),

            Card(
              elevation: 3.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: TextField(
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: Colors.white,),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white,),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: "Username",
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                    prefixIcon: Icon(
                      Icons.perm_identity,
                      color: Colors.black,
                    ),
                  ),
                  maxLines: 1,
                  controller: _usernameControl,
                ),
              ),
            ),

            SizedBox(height: 10.0),

            Card(
              elevation: 3.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: TextField(
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: Colors.white,),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white,),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: "Password",
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Colors.black,
                    ),
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                  ),
                  obscureText: true,
                  maxLines: 1,
                  controller: _passwordControl,
                ),
              ),
            ),

            SizedBox(height: 10.0),

            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                onPressed: (){},
              ),
            ),

            SizedBox(height: 30.0),

            Container(
              height: 50.0,
              child: RaisedButton(
                child: Text(
                  "LOGIN".toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: (){
                  if (_formKey.currentState.validate()) {
                    final email = _usernameControl.text;
                    final password = _passwordControl.text;
                    final firebaseAuth = FirebaseAuth.instance;
                    firebaseAuth
                        .signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    )
                        .then((_) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                            (Route<dynamic> route) => false,
                      );
                    }).catchError((error) =>
                        showErrorDialog(context, error));
                  }
                },
                color: Theme.of(context).accentColor,
              ),
            ),

            SizedBox(height: 10.0),
            Divider(color: Theme.of(context).accentColor,),
            SizedBox(height: 10.0),


            Center(
              child: Container(
                width: MediaQuery.of(context).size.width/2,
                child: Row(
                  children: <Widget>[
                    RawMaterialButton(
                      onPressed: (){},
                      fillColor: Colors.blue[800],
                      shape: CircleBorder(),
                      elevation: 4.0,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Icon(
                          FontAwesomeIcons.facebookF,
                          color: Colors.white,
//              size: 24.0,
                        ),
                      ),
                    ),

                    RawMaterialButton(
                      onPressed: (){},
                      fillColor: Colors.white,
                      shape: CircleBorder(),
                      elevation: 4.0,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Icon(
                          FontAwesomeIcons.google,
                          color: Colors.blue[800],
//              size: 24.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.0),

          ],
        ),
      ),
    );
  }
}

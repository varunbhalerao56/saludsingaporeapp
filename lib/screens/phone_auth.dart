import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:saludsingapore/helpers/export_helper.dart';

import 'package:saludsingapore/screens/main_screen.dart';

class PhoneRegisterScreen extends StatefulWidget {
  final User authCredential;


  const PhoneRegisterScreen({Key key, this.authCredential}) : super(key: key);@override
  _PhoneRegisterScreenState createState() => _PhoneRegisterScreenState();
}

class _PhoneRegisterScreenState extends State<PhoneRegisterScreen> {

  final TextEditingController _otpControl = new TextEditingController();
  final TextEditingController _phoneNumberControl = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String phoneNo, verificationId, smsCode;

  bool codeSent = false;
  @override
  Widget build(BuildContext context) {
    return Container(height: displaySize(context).height, width:  displaySize(context).width,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
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
                  "Create an account",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).accentColor,
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
                  child: TextFormField(
                    onChanged: (val) {
                      setState(() {
                        this.phoneNo = val;
                      });
                    },
                    validator: (value) =>
                    value.isEmpty ? 'Please enter a phoneNumber' : null,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: "Phone Number",

                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                    ),
                    maxLines: 1,
                    controller: _phoneNumberControl,
                  ),
                ),
              ),
              SizedBox(height: 10.0),

              codeSent ?         Card(
                elevation: 3.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: TextFormField(
                    onChanged: (val) {
                      setState(() {
                        this.smsCode = val;
                      });
                    },
                    validator: (value) =>
                    value.isEmpty ? 'Please enter a OTP' : null,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: "OTP",

                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                    ),
                    maxLines: 1,
                    controller: _otpControl,
                  ),
                ),
              ): Container(),

              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: RaisedButton(
                      child: Center(child: codeSent ? Text('Login'):Text('Verify')),
                      onPressed: () {
                        codeSent ? signInWithOTP(smsCode, verificationId):verifyPhone(phoneNo);
                      })),
              SizedBox(height: 40.0),
              Container(
                height: 50.0,
                child: RaisedButton(
                  child: Text(
                    "Register".toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      final phoneNumber = _phoneNumberControl.text;
                      final firebaseAuth = FirebaseAuth.instance;

                      final userId = widget.authCredential.uid;
                      FirebaseFirestore.instance.doc('user/$userId').set(
                          {
                            'phoneNumber': phoneNumber,

                          }, SetOptions(merge : true)

                      );
                    }

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MainScreen()),
                          (Route<dynamic> route) => false,
                    );
                  },
                  color: Theme.of(context).accentColor,
                ),
              ),
              SizedBox(height: 10.0),
              Divider(
                color: Theme.of(context).accentColor,
              ),
              SizedBox(height: 10.0),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Row(
                    children: <Widget>[
                      RawMaterialButton(
                        onPressed: () {},
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
                        onPressed: () {},
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
      ),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      widget.authCredential.linkWithCredential(authResult);
    };

    FirebaseAuth auth = FirebaseAuth.instance;


    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

  signInWithOTP(String smsCode, String verId) {
    AuthCredential authCreds = PhoneAuthProvider.credential(
        verificationId: verId, smsCode: smsCode);
    widget.authCredential.linkWithCredential(authCreds);

  }


}



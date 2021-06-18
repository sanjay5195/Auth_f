import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class phone extends StatefulWidget {
  @override
  _phoneState createState() => _phoneState();
}

class _phoneState extends State<phone> {
  String phoneNumber, smsSent, verificationId;

  Future<void> verifyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsCodeDialoge(context).then((value) {
        print("Code Sent");
      });
    };
    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) {};
    final PhoneVerificationFailed verifyFailed = (FirebaseAuthException e) {
      print('${e.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
  }

  Future<bool> smsCodeDialoge(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Text('Provide OTP'),
          content: TextField(
            onChanged: (value) {
              this.smsSent = value;
            },
          ),
          contentPadding: EdgeInsets.all(10.0),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  User user = FirebaseAuth.instance.currentUser;

                  if (user != null) {
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, "/homepage");
                  } else {
                    Navigator.of(context).pop();
                    signIn(smsSent);
                  }
                  // FirebaseAuth.instance.currentUser().then((user){
                  //
                  //
                  // }
                  // );
                },
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.blue),
                ))
          ],
        );
      },
    );
  }

  Future<void> signIn(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((user) {
      Navigator.of(context).pushReplacementNamed('/loginpage');
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Phone Login"),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Phone number",
              ),
              onChanged: (value) {
                this.phoneNumber = value;
              },
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          RaisedButton(
            onPressed: () {
              verifyPhone;
            },
            child: Text(
              "Verify",
              style: TextStyle(color: Colors.white),
            ),
            elevation: 7.0,
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}

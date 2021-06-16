import 'package:auth_f/Google.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(labelText: "Email"),
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: "Password"),
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
            obscureText: true,
          ),
          FlatButton(onPressed: () {
            FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
                .then((firebaseuser) {

                  Navigator.pushNamed(context, "/homepage");
            }).catchError((e) {
              print(e);
            });
          }, child: Text("Log in")),
          SizedBox(height: 10),
          FlatButton(onPressed: () {}, child: Text("Sign in")),
          SizedBox(height: 10),
          FlatButton(onPressed: () {
            Navigator.pushNamed(context, "/signup");
          }, child: Text("Sign UP")),
          SizedBox(height: 10),
          Google()
        ],
      ),
    );
  }
}

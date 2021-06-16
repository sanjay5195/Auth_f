import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  String email;
  String password;
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  static final String PATH_USER = "users";

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
          FlatButton(
              onPressed: () {
                try {
                  final newUser = _auth
                      .createUserWithEmailAndPassword(
                          email: email, password: password)
                      .then((signInUser) {
                    _fireStore.collection(PATH_USER).add({
                      "email": email,
                      "pass": password,
                    }).then((value) {
                      if (signInUser != null) {
                        Navigator.pushNamed(context, "/homepage");
                      }
                    }).catchError((e) {
                      print(e);
                    });
                  }).catchError((e) {
                    print(e);
                  });
                  if (newUser != null) {
                    Navigator.pushNamed(context, "/homepage");
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Text("Sign UP"))
        ],
      ),
    );
  }
}

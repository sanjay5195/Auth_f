import 'package:auth_f/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class Google extends StatelessWidget {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GoogleSignInButton(darkMode: true,
        onPressed: () {
          signInWithGoogle().then((value) {
            _firestore.collection('users')
                .doc("auth")
                .collection("gusers")
                .add({"email": email, "image": imageUrl, "name": name});
          }).catchError((e) {
            print(e);
          }).then((value) {
            Navigator.pushNamed(context, "/homepage");
          }).catchError((e) {
            print(e);
          });
        },),
    );
  }
}

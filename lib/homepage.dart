import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class homePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(onPressed: () {

            FirebaseAuth.instance.signOut()
                .then((value) {
                  Navigator.pop(context);
            })
            .catchError((e) {
              print(e);
            });
          }, child: Text("Logout"))
        ],
      ),
    );
  }
}
